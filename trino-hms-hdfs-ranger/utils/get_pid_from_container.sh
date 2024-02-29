#!/bin/bash

source "./testlib.sh"

set -e

container_name=$1

hostname=$(getHostnameFromName "$container_name")

docker exec -it "$hostname" jps
