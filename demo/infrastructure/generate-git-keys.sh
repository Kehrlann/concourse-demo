#!/usr/bin/env bash

set -e -u

if [[ -d keys/git ]]; then echo '√ keys already exist'; exit 0; fi

# generate the keys
# --------

mkdir -p keys/git

yes | ssh-keygen -b 4096 -t rsa -f keys/git_rsa -N ''
cp keys/git_rsa.pub keys/git/authorized_keys
chmod -R 700 keys/git
