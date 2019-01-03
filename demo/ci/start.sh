#!/bin/bash

set -e

echo 'Starting ssh server (needs sudo) ...'
sudo service ssh start
echo '  OK'
echo

echo 'Starting PCF dev ...'
CF_STATUS=$(cf dev status)
if [[ "$CF_STATUS" == *"Running"* ]]; then
  echo "Already running, skipping..."
elif [[ "$CF_STATUS" == "Suspended" ]]; then
  cf dev resume
  echo '  OK'
elif [[ "$CF_STATUS" == *"Stopped"* ]]; then
  cf dev start
  echo '  OK'
else
  echo 'Unknown state, aborting ...'
  echo "$CF_STATUS"
  exit 1337
fi

echo
echo 'Starting concourse ...'
docker-compose up -d -V
echo '  OK'
