#!/bin/bash

source "./testlib.sh"

set -e

docker_hostname=$(getHostnameFromName "spark_master")

docker exec -it "$docker_hostname" bin/spark-shell
