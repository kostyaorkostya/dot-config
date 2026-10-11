#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

rm -rf $HOME/.mc && mkdir $HOME/.mc
curl --fail --silent --show-error 'https://raw.githubusercontent.com/peel/mc/master/solarized.ini' \
  >$HOME/.mc/solarized.ini

$DIR/patch_profile.sh
source $HOME/.profile
