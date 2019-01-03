#!/usr/bin/env bash

set -eu

if ! curl -s localhost:5000/v2/_catalog | grep alpine -q; then
  docker pull alpine
  docker tag alpine localhost:5000/alpine
  docker push localhost:5000/alpine
else
  echo '√ local alpine repo already exists'
fi
