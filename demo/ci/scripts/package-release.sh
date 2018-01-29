#!/bin/ash

PROD_FOLDER=$PWD/prod
RELEASE_FOLDER=$PWD/release
TAR_FOLDER=/tmp/tar
VERSION=$(cat release-version/version)
TAR_FILE="$RELEASE_FOLDER/todo-$VERSION.tgz"
mkdir -p $TAR_FOLDER/frontend
mkdir -p $TAR_FOLDER/backend

cp -R frontend-bucket/* $TAR_FOLDER/frontend
cp backend-bucket/*.jar $TAR_FOLDER/backend/todo.jar
tar -czf $TAR_FILE -C $TAR_FOLDER .
mv $TAR_FILE $ELEASE_FOLDER

mkdir -p $PROD_FOLDER/frontend
mkdir -p $PROD_FOLDER/backend
cp -R frontend-bucket/* $PROD_FOLDER/frontend
cp backend-bucket/*.jar $PROD_FOLDER/backend
cp manifests-repo/prod.yml $PROD_FOLDER/manifest.yml
