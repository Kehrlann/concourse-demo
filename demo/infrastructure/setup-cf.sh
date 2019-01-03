#!/bin/bash

cf create-space ci
cf create-space prod
cf create-domain pcfdev-org ci.local.pcfdev.io
