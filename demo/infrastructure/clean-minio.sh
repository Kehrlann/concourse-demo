#!/bin/bash

mc config host add local http://localhost:9000/ minio changeme
mc rm -r --force "local/todo-app"
mc rm -r --force "local/todo-backend"
mc rm -r --force "local/todo-frontend"
mc rm -r --force "local/todo-version"
