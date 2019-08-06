#!/bin/bash

set -eu

cd repo/demo/frontend
mv /tmp/node_modules .

APP_URL=http://todo.ci.dev.cfdev.sh yarn e2e-ci
