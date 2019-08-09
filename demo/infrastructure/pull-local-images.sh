#!/usr/bin/env bash

set -eu

export VAULT_CLIENT_TOKEN="FAKE_CLIENT_TOKEN"
export VAULT_ADMIN_TOKEN="FAKE_ADMIN_TOKEN"

function start_registry() {
  echo 'Starting registry in mirror mode...'
  docker-compose -f docker-compose.yml -f docker-compose.registry.yml up -d registry
  sleep 3
  echo '√ OK'
}

function stop_registry() {
  echo 'Stopping registry...'
  docker-compose down -v
  echo '√ OK'
}

function pull_and_save() {
  local image="$1"
  local tag=${2:-"latest"}
  if [[ $(curl -s localhost:5000/v2/_catalog | jq -r '.repositories | index("library/'"$image"'")') == "null" ]]; then
    echo "Pulling $image ..."
    docker pull "$image:$tag"
    if !grep mirror /etc/docker/daemon.json; then
      echo 'Docker is not in mirrored mode, pushing image to local registry...'
      docker tag "$image:$tag" localhost:5000/"$image:$tag"
      docker push localhost:5000/"$image:$tag"
    fi
    echo '√ OK'
  else
    echo "√ image $image already exists in local registry"
  fi
}

trap stop_registry EXIT

start_registry
pull_and_save alpine
pull_and_save openjdk 8-jre-alpine
pull_and_save nginx "1.15.8-alpine"
