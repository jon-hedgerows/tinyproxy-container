#!/bin/bash

./test-build.sh docker

export TINYPROXY_IMAGE=tinyproxy:dev
docker compose up
