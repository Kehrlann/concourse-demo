#!/usr/bin/env bash

set -eu

function check_for_mirror() {
  if grep mirror /etc/docker/daemon.json; then
    echo '√ docker daemon has a mirror, pulling required images'
  else
    echo 'x docker daemon is not configured with a mirror. Skipping initial pull.'
    echo 0
  fi
}

function pull_and_save() {
  local image="$1"
  local tag=${2:-"latest"}
  if [[ $(curl -s localhost:5000/v2/_catalog | jq -r '.repositories | index("library/'"$image"'")') == "null" ]]; then
    docker pull "$image:$tag"
  else
    echo "√ image $image already exists in local registry"
  fi
}

check_for_mirror
pull_and_save alpine
pull_and_save openjdk 8-jre-alpine
