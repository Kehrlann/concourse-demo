#!/bin/bash

set -eu

cd repo/demo/frontend
mv /tmp/node_modules .
CI=true yarn test
