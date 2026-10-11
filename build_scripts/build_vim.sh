#!/bin/bash -e
#
# Bash script to install Vim on systems without root access.
#
# Python, Lua, Ruby and Perl support depends on the presence
# of corresponding development packages.

usage() {
    printf 'Usage: %s {-p|--prefix} DIR

Options:
    {-p|--prefix}   Path to the installation directory.
    {-h|--help}     Print usage.
' "$1" >&2
    exit 1
}

INSTALL_PREFIX=''

while [ $# -gt 0 ]; do
    case "$1" in
        -h)
            usage $0
            ;;
        --help)
            usage $0
            ;;
        -p)
            INSTALL_PREFIX="$2"
            shift
            ;;
        --prefix)
            INSTALL_PREFIX="$2"
            shift
            ;;
        -*)
            printf 'Error: Unknown option "%s".\n' "$1" >&2
            usage $0
            ;;
        *)
            break
            ;;
    esac
    shift
done

if [[ -z "${INSTALL_PREFIX}" ]]; then
    printf 'Error: "{-p|--prefix}" is required.\n' >&2
    usage $0
fi

INSTALL_PREFIX=$(echo "$(cd "${INSTALL_PREFIX}"; pwd)")

PLATFORM=$(uname)

MAKE_TOOL='make'
if [[ "${PLATFORM}" == *FreeBSD* ]]; then
    MAKE_TOOL='gmake'
elif [[ "${PLATFORM}" == *Darwin* ]]; then
    printf 'Use homebrew instead. See http://brew.sh/ for details.\n'
    exit 1
fi

TMP_DIR="$(mktemp -d -t 'vim_build.XXXXXXXXXX')"
VIM_SOURCE_DIR=''
NCURCES_SOURCE_DIR=''

cleanup() {
    rm -rf "${TMP_DIR}"
}

download() {
    # $1 -- target directory
    #
    # As a side effect will set global variables $VIM_SOURCE_DIR and $NCURCES_SOURCE_DIR.

    local target_direcory=$1

    local vim_url='https://github.com/vim/vim/archive/v8.0.0085.tar.gz'
    local ncurses_url='http://invisible-mirror.net/archives/ncurses/ncurses-6.0.tar.gz'

    wget --verbose \
         --tries 10 \
         --progress dot \
         --retry-connrefused \
         --no-check-certificate \
         --output-document - \
        "${vim_url}" \
        | tar \
            --extract \
            --gzip \
            --file - \
            --directory "${target_direcory}" &
    wget --verbose \
         --tries 10 \
         --progress dot \
         --retry-connrefused \
         --no-check-certificate \
         --output-document - \
        "${ncurses_url}" \
        | tar \
            --extract \
            --gzip \
            --file - \
            --directory "${target_direcory}" &
    wait

    VIM_SOURCE_DIR="${target_direcory}/vim-8.0.0085"
    NCURCES_SOURCE_DIR="${target_direcory}/ncurses-6.0"
}

build_ncurses() {
    # $1 -- ncurses sources direcrory
    # $2 -- installation prefix
    # $3 -- make tool

    local source_dir=$1
    local install_prefix=$2
    local make_tool=$3

    cd "${source_dir}"
    ./configure \
        --prefix="${install_prefix}" \
        --enable-256-color \
        --with-shared \
        --silent
    eval nice "${make_tool}" -j
    eval "${make_tool}" install
}

build_vim() {
    # $1 -- Vim source directory
    # $2 -- installation prefix
    # $3 -- make tool

    local source_dir=$1
    local install_prefix=$2
    local make_tool=$3

    local compiled_by_line='Kostya Bazhanov. See https://github.com/kostyaorkostya/dot-config/blob/main/build_scripts/build_vim.sh for details.'

    cd "${source_dir}"
    CPPFLAGS="-I${install_prefix}/include" \
        LDFLAGS="-L${install_prefix}/lib" \
        ./configure \
            --prefix="${install_prefix}" \
            --with-compiledby="${compiled_by_line}" \
            --with-features=huge \
            --enable-multibyte \
            --enable-pythoninterp \
            --enable-rubyinterp \
            --enable-perlinterp \
            --enable-luainterp \
            --with-luajit \
            --with-tlib=ncurses \
            --enable-gui=gtk2 \
            --enable-cscope \
            --disable-darwin \
            --disable-netbeans \
            --disable-gui \
            --disable-xsmp \
            --disable-xsmp-interact \
            --without-x \
            --silent
    eval "${make_tool}" -j
    eval "${make_tool}" install
}

trap cleanup EXIT

download "${TMP_DIR}"
build_ncurses "${NCURCES_SOURCE_DIR}" "${INSTALL_PREFIX}" "${MAKE_TOOL}"
build_vim "${VIM_SOURCE_DIR}" "${INSTALL_PREFIX}" "${MAKE_TOOL}"

## Give direction on how to start using it.

printf '\nAdd "%s/bin" to your $PATH to use this Vim binary by default.\n' "${INSTALL_PREFIX}"
