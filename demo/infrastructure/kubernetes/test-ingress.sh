#!/usr/bin/env bash

kubectl run kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1 --port=8080
kubectl run echoserver --image=gcr.io/google_containers/echoserver:1.4 --port=8080
kubectl expose deployment kubernetes-bootcamp --type=NodePort
kubectl expose deployment echoserver --type=NodePort
