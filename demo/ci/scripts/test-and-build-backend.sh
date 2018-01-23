#!/bin/bash

set -eu

SOURCE_DIR=$PWD/repo/demo/backend
OUTPUT_DIR=$PWD/build

cd $SOURCE_DIR
mvn -s /usr/share/maven/ref/settings.xml \
    clean package \
    -DdisablexmlReport=true \
    -Dsurefire.useFile=false

mv target/*.jar $OUTPUT_DIR
