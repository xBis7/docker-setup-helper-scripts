#!/bin/bash

source "./testlib.sh"

set -e

container_name=$1
use_jps=$2

hostname=$(getHostnameFromName "$container_name")

if [ "$use_jps" == "false" ]; then
  docker exec -it "$hostname" bash -c "ps aux | grep java"
else
  docker exec -it "$hostname" jps
fi

