#!/bin/bash

fly -t ci set-pipeline -p test-pipeline -c pipeline.yml

