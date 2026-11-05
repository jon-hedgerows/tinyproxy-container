#!/bin/ash
# shellcheck shell=ash

: "${TINYPROXY_PORT:=8888}"
: "${TINYPROXY_HEALTHCHECKURL:=http://tinyproxy.stats}"

curl --silent --show-error --fail --proxy "http://localhost:${TINYPROXY_PORT}" --head "${TINYPROXY_HEALTHCHECKURL}" --output /dev/null
