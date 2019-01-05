#!/bin/bash

set -e

function start_ssh_server() {
  echo 'Starting ssh server (needs sudo) ...'
  sudo service ssh start
  echo '  OK'
  echo
}

function start_pcf() {
  echo 'Starting PCF dev ...'
  ./boot-cf.sh
  echo '  OK'
}

function start_concourse() {
  echo
  echo 'Generating keys for concourse ...'
  ./generate-keys.sh
  echo '  OK'

  echo
  echo 'Generating tokens for vault ...'
  ./generate-vault-tokens.sh
  echo '  OK'

  echo
  echo 'Loading vault tokens'
  export VAULT_CLIENT_TOKEN=$(cat keys/vault-client-token.txt)
  export VAULT_ADMIN_TOKEN=$(cat keys/vault-admin-token.txt)
  echo '  OK'

  echo
  echo 'Starting concourse ...'
  docker-compose up -d -V
  echo '  OK'

  echo
  echo 'Waiting for containers to become healthy ...'
  echo -n '.'
  while [[ -z $(docker-compose ps minio | grep healthy) ]]; do
    sleep 5
    echo -n '.'
  done
  echo '  OK'
}

function setup_cf() {
  echo
  echo 'Cleaning up CF'
  ./clean-cf.sh | true
  echo '  OK'

  echo
  echo 'Setting up CF'
  ./setup-cf.sh | true
  echo '  OK'
}

function setup_minio() {
  echo
  echo 'Cleaning up minio'
  ./clean-minio.sh | true
  echo '  OK'


  echo
  echo 'Setting up minio'
  ./setup-minio.sh | true
  echo '  OK'
}

function pull_local_alpine() {
  echo
  echo 'Pulling local alpine ...'
  ./pull-local-alpine.sh
  echo '  OK'
}

function setup_vault() {
  echo
  echo 'Setting up vault ...'
  ./setup-vault.sh
  echo '  OK'
}

start_ssh_server
start_pcf
setup_cf
start_concourse
setup_minio
setup_vault
pull_local_alpine

echo
echo

echo 'All good now, ready to fly !'
