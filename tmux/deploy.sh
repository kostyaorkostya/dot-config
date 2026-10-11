#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

printf 'Copying default Tmux config...\n'
cp -f "${DIR}/tmux-common.conf" "${HOME}/.tmux.conf"
printf 'Copying default Tmux config...DONE\n'

if [ -n "${TMUX}" ]; then
  tmux source-file "${HOME}/.tmux.conf" >/dev/null
fi
