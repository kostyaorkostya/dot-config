#!/bin/bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cat $DIR/profile_patch.sh >>$HOME/.profile
