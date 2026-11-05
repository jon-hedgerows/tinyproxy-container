#!/bin/bash

if [[ -n "$1" || -z "$(which container)" ]] ; then
  docker buildx build -t tinyproxy:dev .
else
  container build -t tinyproxy:dev .
fi
