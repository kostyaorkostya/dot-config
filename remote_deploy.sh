#!/bin/bash -e

REPO_DIR="$(mktemp -d -t 'dot-config.XXXXXXXXXX')"

cleanup() {
    rm -rf "${REPO_DIR}"
}

trap cleanup EXIT

git clone --quiet https://github.com/kostyaorkostya/dot-config.git "${REPO_DIR}"
eval "${REPO_DIR}/deploy.sh"
