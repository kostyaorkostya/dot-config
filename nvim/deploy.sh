#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="${HOME}/.config/nvim"
BACKUP="${HOME}/old-nvim-config"

printf 'Backing up old Neovim config...\n'
if [ -e "${BACKUP}" ]; then
	rm -rf "${BACKUP}"
fi
if [ -e "${TARGET}" ]; then
	mv "${TARGET}" "${BACKUP}"
fi
printf 'Backing up old Neovim config...DONE\n'

printf 'Copying new Neovim config...\n'
mkdir -p "${TARGET}"
cp "${DIR}/init.lua" "${TARGET}/init.lua"
cp -r "${DIR}/lua" "${TARGET}/lua"
printf 'Copying new Neovim config...DONE\n'

# Note: nvim-treesitter's :TSUpdate build step needs a C compiler and the
# tree-sitter CLI to compile parsers. If those are missing, the affected
# parsers fail silently and the rest of the sync (and this script) still
# succeed.
printf 'Installing Neovim plugins...\n'
nvim --headless "+Lazy! sync" "+qa!"
printf 'Installing Neovim plugins...DONE\n'
