#!/bin/ash

set -e

PROD_FOLDER=$PWD/prod
VERSION=$(cat repo/demo/ci/version/version-prod.txt)

mkdir -p /tmp

mc config host add "$endpoint" "$access_key_id" "$secret_access_key"
mc cp minio/todo-app/todo-"$VERSION".tgz /tmp
cd $PROD_FOLDER
tar -xzf /tmp/todo-"$VERSION".tgz # --strip-components=1

cp repo/demo/ci/manifests/prod.yml $PROD_FOLDER/manifest.yml
