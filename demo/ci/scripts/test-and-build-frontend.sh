#!/bin/bash

set -eu

OUTPUT_DIR=$PWD/build
GIT_REPO="$PWD/repo/.git"

# This allows running tasks with `fly execute`
# Because fly execute does not upload the git repo
if [ -f "$GIT_REPO/ref" ]; then
  COMMIT_REF=$(cat $GIT_REPO/ref)
else
  COMMIT_REF="local"
fi

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
