#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

printf '\n' >>$HOME/.zshrc
cat $DIR/profile_patch.sh >>$HOME/.zshrc
