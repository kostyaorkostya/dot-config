#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

printf 'Configuring...\n'

printf 'Configuring zsh...\n'
"${DIR}/zsh/deploy.sh"
printf 'Configuring zsh...DONE\n'

printf 'Configuring Midnight Commander...\n'
"${DIR}/mc/deploy.sh"
printf 'Configuring Midnight Commander...DONE\n'

printf 'Configuring Tmux...\n'
"${DIR}/tmux/deploy.sh"
printf 'Configuring Tmux...DONE\n'

printf 'Configuring Vim...\n'
"${DIR}/vim/deploy.sh"
printf 'Configuring Vim...DONE\n'

printf 'Configuring Python...\n'
"${DIR}/python/deploy.sh"
printf 'Configuring Python...DONE\n'

printf 'Configuring GDB...\n'
"${DIR}/gdb/deploy.sh"
printf 'Configuring GDB...DONE\n'

printf 'Configuring...DONE\n'
