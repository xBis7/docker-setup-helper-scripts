#!/bin/bash

source "./testlib.sh"

set -e

container_name=$1
prof_time=$2
flamegraph_name=$3
pid=$4

hostname=$(getHostnameFromName "$container_name")

docker exec -it "$hostname" /profiler/bin/asprof --fdtransfer -d "$prof_time" -f /tmp/"$flamegraph_name".html "$pid"
