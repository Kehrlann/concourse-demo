#!/bin/bash

set -e

CF_STATUS=$(cf dev status)
if [[ "$CF_STATUS" == *"Running"* ]]; then
  echo "Already running, skipping..."
elif [[ "$CF_STATUS" == "Suspended" ]]; then
  set +e
  SYSTEMCTL_STATUS=$(systemctl --user status cf-dev)
  set -e
  if [[ -z "$SYSTEMCTL_STATUS" ]]; then
    cf dev resume
  else
    systemctl --user start cf-dev
  fi
  echo 'Resumed'
elif [[ "$CF_STATUS" == *"Stopped"* ]]; then
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
