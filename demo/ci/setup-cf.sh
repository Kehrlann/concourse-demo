#!/bin/bash

cf create-space ci
cf create-space preprod
cf create-space prod
cf create-domain pcfdev-org ci.local.pcfdev.io
cf create-domain pcfdev-org preprod.local.pcfdev.io
