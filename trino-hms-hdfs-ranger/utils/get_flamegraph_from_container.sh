#!/bin/bash

source "./testlib.sh"

set -e

container_name=$1
flamegraph_name=$2
local_path=$3

hostname=$(getHostnameFromName "$container_name")

docker cp "$hostname":/tmp/"$flamegraph_name".html "$local_path"
