#!/bin/bash

set -e

CF_STATUS=$(cf dev status)
if [[ "$CF_STATUS" == *"Running"* ]]; then
  echo "Already running, skipping..."
elif [[ "$CF_STATUS" == "Suspended" ]]; then
  cf dev resume
  echo 'Resumed'
elif [[ "$CF_STATUS" == *"Stopped"* ]] || [[ "$CF_STATUS" == "Not Created" ]]; then
  cf dev start
  echo 'Started'
else
  echo 'Unknown state, aborting ...'
  echo "$CF_STATUS"
  exit 1337
fi

echo
echo 'Logging in to PCF ...'
cf login -a api.local.pcfdev.io --skip-ssl-validation -u admin -p admin -o pcfdev-org -s pcfdev-space
echo '  OK'
