#!/bin/bash

cf t -s ci
cf d web-app
cf d backend

cf t -s prod 
cf d web-app
cf d backend
