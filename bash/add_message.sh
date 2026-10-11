#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

printf '\n' >>$HOME/.profile
cat $DIR/message.sh >>$HOME/.profile
source $HOME/.profile

unset DIR
