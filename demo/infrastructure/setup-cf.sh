#!/bin/bash

cf create-space ci
cf create-space prod
cf create-domain cfdev-org ci.local.pcfdev.io
