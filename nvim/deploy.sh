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
cp "${DIR}/nvim-pack-lock.json" "${TARGET}/nvim-pack-lock.json"
printf 'Copying new Neovim config...DONE\n'

# nvim-treesitter compiles parsers with the tree-sitter CLI (>= 0.26.1) and a
# C compiler.
printf 'Installing Neovim plugins...\n'
# Parsers built by the old nvim-treesitter master branch. main installs to
# site/parser, but these stay on 'runtimepath' and still get loaded (e.g. a
# tmux parser that main no longer ships queries for).
TS_PLUGIN="${XDG_DATA_HOME:-${HOME}/.local/share}/nvim/site/pack/core/opt/nvim-treesitter"
rm -rf "${TS_PLUGIN}/parser" "${TS_PLUGIN}/parser-info"
nvim --headless "+lua vim.pack.update(nil, { force = true, target = 'lockfile' })" "+qa!"
# Separate process: the update above can swap plugin code under modules that
# this session already loaded.
nvim --headless "+lua require('nvim-treesitter').update():wait(300000)" "+qa!"
printf 'Installing Neovim plugins...DONE\n'
