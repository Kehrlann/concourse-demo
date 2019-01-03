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
echo 'Logging in to PCF ...'
cf login -a api.local.pcfdev.io --skip-ssl-validation -u admin -p admin -o pcfdev-org -s pcfdev-space
echo '  OK'

echo
echo 'Starting concourse ...'
docker-compose up -d -V
echo '  OK'

echo
echo 'Waiting for containers to become healthy ...'
echo -n '.'
while [[ -z $(docker-compose ps minio | grep healthy) ]]; do
  sleep 5
  echo -n '.'
done
echo '  OK'

echo
echo 'Cleaning up CF'
./clean-cf.sh | true
echo '  OK'

echo
echo 'Cleaning up minio'
./clean-minio.sh | true
echo '  OK'

echo
echo 'Setting up CF'
./setup-cf.sh | true
echo '  OK'

echo
echo 'Setting up minio'
./setup-minio.sh | true
echo '  OK'

echo
echo

echo 'All good now, ready to fly !'
