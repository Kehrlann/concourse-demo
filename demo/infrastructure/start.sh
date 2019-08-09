#!/bin/bash

set -e

function delete_all_keys() {
  echo 'Deleting all keys and tokens...'
  rm -rf keys/*
  echo '  OK'
  echo
}

function start_pcf() {
  echo 'Starting PCF dev ...'
  ./boot-cf.sh
  echo '  OK'
}

function start_docker_compose() {
  echo
  echo 'Generating keys for concourse ...'
  ./generate-concourse-keys.sh --use-pem
  echo '  OK'

  echo
  echo 'Generating tokens for vault ...'
  ./generate-vault-tokens.sh
  echo '  OK'

  echo
  echo 'Generating keys for git ...'
  ./generate-git-keys.sh
  echo '  OK'

  echo
  echo 'Loading vault tokens'
  export VAULT_CLIENT_TOKEN=$(cat keys/vault-client-token.txt)
  export VAULT_ADMIN_TOKEN=$(cat keys/vault-admin-token.txt)
  echo '  OK'

  echo
  echo 'Getting minikube IP'
  export MINIKUBE_IP=$(minikube ip)
  echo '  OK'

  echo
  echo 'Creating registry volume ...'
  docker volume create --name=registry
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

function pull_local_images() {
  echo
  echo 'Pulling local docker images ...'
  ./pull-local-images.sh
  echo '  OK'
}

function build_base_images() {
  echo
  echo 'Building base images ...'
  ./build-base-images.sh
  echo '  OK'
}

function setup_vault() {
  echo
  echo 'Setting up vault ...'
  ./setup-vault.sh
  echo '  OK'
}

if [[ "$1" == "--with-cf" ]]; then
  start_pcf
  setup_cf
fi
delete_all_keys
pull_local_images
start_docker_compose
setup_minio
setup_vault
build_base_images

echo
echo

echo 'All good now, ready to fly !'
