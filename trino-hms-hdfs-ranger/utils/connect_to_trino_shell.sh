#!/bin/bash

source "./testlib.sh"

set -e

user=$1

docker_hostname=$(getHostnameFromName "trino")

if [ "$user" != "" ]; then
  docker exec -it -u "$user" "$docker_hostname" trino --debug
else
  docker exec -it "$docker_hostname" trino --debug
fi
