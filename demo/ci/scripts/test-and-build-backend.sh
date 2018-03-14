#!/bin/bash

set -eu

GIT_DIR=$PWD/repo/.git
SOURCE_DIR=$PWD/repo/demo/backend
OUTPUT_DIR=$PWD/build
COMMIT_REF=$(cat $GIT_DIR/ref)

cd $SOURCE_DIR
mvn -s /usr/share/maven/ref/settings.xml \
    clean package \
    -DdisablexmlReport=true \
    -Dsurefire.useFile=false \
    -Dlogging.level.org.springframework=WARN

mkdir -p OUTPUT_DIR
mv target/*.jar $OUTPUT_DIR/backend-$COMMIT_REF.jar
