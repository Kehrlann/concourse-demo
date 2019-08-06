#!/bin/bash

set -e

echo 'Starting PCF dev'
cf dev start
echo '  OK'

echo
echo 'Logging in to PCF ...'
cf login -a api.dev.cfdev.sh --skip-ssl-validation -u admin -p admin -o cfdev-org -s cfdev-space
echo '  OK'
