#!/bin/ash
# shellcheck shell=ash

# first check if a replacement tinyproxy.conf has been provided, if it has, then use it
if test -f /conf/tinyproxy.conf ; then
  # use the provided conf, logging to stdout for docker
  printf -- "Configured with provided /conf/tinyproxy.conf\n\n"
  exec /usr/bin/tinyproxy -c /conf/tinyproxy.conf -d
fi

# otherwise configure using environment variables
: "${TINYPROXY_ALLOWLIST:=192.168.0.0/16,172.16.0.0/12,10.0.0.0/8,fd00::/8,169.254.0.0/15,fe80::/10}"
: "${TINYPROXY_PORT:=8888}"
: "${TINYPROXY_LISTEN:=0.0.0.0}"
TINYPROXY_LOGLEVEL=$(printf "%s" "${TINYPROXY_LOGLEVEL:=connect}" | awk '{print tolower($0)}')

# validate log level
case "$TINYPROXY_LOGLEVEL" in
  critical)
  ;;
  error)
  ;;
  warning)
  ;;
  notice)
  ;;
  connect)
  ;;
  info)
  ;;
  *)
    printf "Error: TINYPROXY_LOGLEVEL set to an unknown value %s, reverted to \"connect\"\n" "${TINYPROXY_LOGLEVEL}"
    TINYPROXY_LOGLEVEL=connect
  ;;
esac

# configure with vars
{
  # ensure that the value's we're overriding are not present, except Allow
  grep -Eiv "^Port|^Listen|^LogLevel" /etc/tinyproxy/tinyproxy.conf
  # add to the allow list
  printf "%s\n" "${TINYPROXY_ALLOWLIST}" | awk '{split($1,a,",");for(i in a)print "Allow "a[i]}'
  # set the listen port and address
  printf "Port %5s\n" "${TINYPROXY_PORT}"
  printf "Listen %15s\n" "${TINYPROXY_LISTEN}"
  # set the log level
  printf "LogLevel %7s\n" "${TINYPROXY_LOGLEVEL}"
} > /tmp/tinyproxy.conf
printf -- "Configuration:\n---\n"
grep -Ev "^$|^#" /tmp/tinyproxy.conf
printf -- "---\n\n"
exec /usr/bin/tinyproxy -c /tmp/tinyproxy.conf -d
