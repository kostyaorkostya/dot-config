#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cp $DIR/profile.sh $HOME/.profile

if [ "$1" == '--with-message' ]; then
  $DIR/add_message.sh
fi

source $HOME/.profile

unset DIR
