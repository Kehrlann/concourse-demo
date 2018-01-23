#!/bin/bash

set -ex

cd repo/demo/frontend
mv /tmp/node_modules .
CI=true yarn test
