#!/usr/bin/env bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$SCRIPT_DIR/../../"

function build_local_image() {
  local base_image_name="$1"
  local image_name="localhost:5000/$base_image_name"
  local path="$BASE_DIR/$2"
  local dockerfile="$path/$3"
  if [[ $(curl -s localhost:5000/v2/_catalog | jq -r '.repositories | index("'"$base_image_name"'")') == "null" ]]; then
    echo "x image $base_image_name not found locally, building ..."
    docker build -f "$dockerfile" -t "$image_name" "$path"
    docker push "$image_name"
  else
    echo "√ image $base_image_name already exists in local registry"
  fi
}

build_local_image "todo-build-backend" "demo/backend" "concourse-dockerfile"
build_local_image "todo-build-frontend" "demo/frontend" "concourse-dockerfile"
build_local_image "todo-run-e2e" "demo/frontend" "concourse-e2e-dockerfile"
