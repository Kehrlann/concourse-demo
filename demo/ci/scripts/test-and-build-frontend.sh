#!/bin/bash

set -eu

OUTPUT_DIR=$PWD/build
GIT_REPO="$PWD/repo/.git"
COMMIT_REF=$(cat $GIT_REPO/ref || echo local)

cd repo/demo/frontend
mv /tmp/node_modules .
CI=true yarn test
yarn build

# Copy the files for deploying to CF
mkdir -p $OUTPUT_DIR/dist
cp -R build/* $OUTPUT_DIR/dist

# Package the artifact to upload to minio
TAR_FILE="frontend-$COMMIT_REF.tgz"
tar -czf $TAR_FILE -C build .
mv $TAR_FILE $OUTPUT_DIR
