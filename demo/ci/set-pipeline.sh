#!/bin/bash

fly -t ci set-pipeline -p test -c pipeline.yml

