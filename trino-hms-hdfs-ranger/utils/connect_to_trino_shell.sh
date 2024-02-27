#!/bin/bash

source "./testlib.sh"

set -e

docker_hostname=$(getHostnameFromName "trino")

docker exec -it "$docker_hostname" trino
