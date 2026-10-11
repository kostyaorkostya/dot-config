#!/bin/bash -e
#
# Bash script to install Tmux on systems without root access.

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
      usage "$0"
      ;;
    --help)
      usage "$0"
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
      usage "$0"
      ;;
    *)
      break
      ;;
  esac
  shift
done

if [[ -z "${INSTALL_PREFIX}" ]]; then
  printf 'Error: "{-p|--prefix}" is required.\n' >&2
  usage "$0"
fi

INSTALL_PREFIX="$(cd "${INSTALL_PREFIX}" && pwd)"

PLATFORM=$(uname)

MAKE_TOOL='make'
if [[ "${PLATFORM}" == *FreeBSD* ]]; then
  MAKE_TOOL='gmake'
elif [[ "${PLATFORM}" == *Darwin* ]]; then
  printf 'Use homebrew instead. See http://brew.sh/ for details.\n'
  exit 1
fi

## Download sources

TMP_DIR="$(mktemp -d -t 'tmux_build.XXXXXXXXXX')"
TMUX_SOURCE_DIR=''
NCURCES_SOURCE_DIR=''
LIBEVENT_SOURCE_DIR=''

cleanup() {
  rm -rf "${TMP_DIR}"
}

download() {
  # $1 -- target directory
  #
  # As a side effect will set $TMUX_SOURCE_DIR, $NCURSES_SOURCE_DIR and $LIBEVENT_SOURCE_DIR
  # global variables.

  local target_direcory=$1
  local tmux_url='http://downloads.sourceforge.net/tmux/tmux-1.9a.tar.gz'
  local ncurses_url='ftp://invisible-island.net/ncurses/ncurses.tar.gz'
  local libevent_url='http://sourceforge.net/projects/levent/files/libevent/libevent-2.0/libevent-2.0.21-stable.tar.gz/download'

  wget \
    --no-check-certificate \
    --quiet \
    "${tmux_url}" \
    --output-document - \
    | tar \
      --extract \
      --gzip \
      --file - \
      --directory "${target_direcory}" &
  curl \
    --fail \
    --silent \
    --show-error \
    "${ncurses_url}" \
    | tar \
      --extract \
      --gzip \
      --file - \
      --directory "${target_direcory}" &
  wget \
    --no-check-certificate \
    --quiet \
    "${libevent_url}" \
    --output-document - \
    | tar \
      --extract \
      --gzip \
      --file - \
      --directory "${target_direcory}" &
  wait

  TMUX_SOURCE_DIR="${target_direcory}/tmux-1.9a"
  NCURCES_SOURCE_DIR="${target_direcory}/ncurses-5.9"
  LIBEVENT_SOURCE_DIR="${target_direcory}/libevent-2.0.21-stable"
}

build_ncurses() {
  # $1 -- ncurses sources direcrory
  # $2 -- installation prefix
  # $3 -- make tool

  local source_dir=$1
  local install_prefix=$2
  local make_tool=$3

  cd "${source_dir}"
  ./configure --prefix="${install_prefix}" \
    --enable-256-color \
    --disable-shared \
    --enable-static \
    --silent
  eval "${make_tool}" -j
  eval "${make_tool}" install
}

build_libevent() {
  # $1 -- libevent sources directory
  # $2 -- installation prefix
  # $3 -- make tool

  local source_dir=$1
  local install_prefix=$2
  local make_tool=$3

  cd "${source_dir}"
  ./configure \
    --prefix="${install_prefix}" \
    --disable-shared \
    --enable-static \
    --silent
  eval "${make_tool}" -j --quiet
  eval "${make_tool}" install --quiet
}

build_tmux() {
  # $1 -- tmux sources directory
  # $2 -- installation prefix
  # $3 -- make tool

  local source_dir=$1
  local install_prefix=$2
  local make_tool=$3

  cd "${source_dir}"
  CPPFLAGS="-I${install_prefix}/include" \
    LDFLAGS="-L${install_prefix}/lib" \
    ./configure \
    --prefix="${install_prefix}" \
    --disable-shared \
    --enable-static \
    --silent
  eval "${make_tool}" -j --quiet
  eval "${make_tool}" install --quiet
}

trap cleanup EXIT

download "${TMP_DIR}"
build_ncurses "${NCURCES_SOURCE_DIR}" "${INSTALL_PREFIX}" "${MAKE_TOOL}"
build_libevent "${LIBEVENT_SOURCE_DIR}" "${INSTALL_PREFIX}" "${MAKE_TOOL}"
build_tmux "${TMUX_SOURCE_DIR}" "${INSTALL_PREFIX}" "${MAKE_TOOL}"

## Give direction on how to start using it.

# shellcheck disable=SC2016
printf '\nAdd "%s/bin" to your $PATH to use this Tmux binary by default.\n' "${INSTALL_PREFIX}"
