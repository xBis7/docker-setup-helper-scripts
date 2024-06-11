#!/bin/bash

source "./testlib.sh"

set -e

name=$1
user=$2

docker_hostname=$(getHostnameFromName "$name")

if [ "$user" != "" ]; then
  docker exec -it -u "$user" "$docker_hostname" bash
else
  docker exec -it "$docker_hostname" bash
fi
