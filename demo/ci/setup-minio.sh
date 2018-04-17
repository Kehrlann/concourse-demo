#!/bin/bash

mc config host add local http://localhost:9000/ minio changeme
mc mb "local/todo-app"
mc mb "local/todo-backend"
mc mb "local/todo-frontend"
mc mb "local/todo-version"
