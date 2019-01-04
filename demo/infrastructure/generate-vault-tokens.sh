#!/usr/bin/env bash

mkdir -p keys

uuidgen > keys/vault-admin-token.txt
uuidgen > keys/vault-client-token.txt
