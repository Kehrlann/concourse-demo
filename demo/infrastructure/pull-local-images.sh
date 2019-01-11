#!/usr/bin/env bash

set -eu

function pull_and_save() {
  local image="$1"
  if [[ $(curl -s localhost:5000/v2/_catalog | jq -r '.repositories | index("'"$image"'")') == "null" ]]; then
    docker pull "$image"
    docker tag "$image" localhost:5000/"$image"
    docker push localhost:5000/"$image"
  else
    echo "√ local image $image already exists"
  fi
}

pull_and_save alpine
pull_and_save openjdk:8-alpine
