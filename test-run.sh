#!/bin/bash

if [[ -n "$1" || -z "$(which container)" ]] ; then
  docker run --env-file ./env -p 0.0.0.0:8888:8888 tinyproxy:dev
else
  container run --env-file ./env -p 0.0.0.0:8888:8888 tinyproxy:dev
fi
