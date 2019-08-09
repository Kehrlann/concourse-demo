#!/bin/bash

set -e

if minikube status | grep Running; then
  echo '√ Minikube already running, skipping ...'
else
  echo 'Starting minikube'
  minikube start
  echo '  OK'
fi
