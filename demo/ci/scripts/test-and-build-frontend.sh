#!/bin/bash

set -eu

OUTPUT_DIR=$PWD/build

cd repo/demo/frontend
mv /tmp/node_modules .
CI=true yarn test
yarn build
cp -R build/* $OUTPUT_DIR
