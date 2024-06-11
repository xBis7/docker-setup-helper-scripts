#!/bin/bash

source "./testlib.sh"

set -e

user=$1

docker_hostname=$(getHostnameFromName "spark_master")

if [ "$user" != "" ]; then
  docker exec -it -u "$user" "$docker_hostname" bin/spark-shell
else
  docker exec -it "$docker_hostname" bin/spark-shell
fi