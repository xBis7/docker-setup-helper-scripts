#!/bin/bash

source "./testlib.sh"

set -e

profiler_path=$1
container_name=$2

profiler_dir="async-profiler-3.0-linux-x64"

hostname=$(getHostnameFromName "$container_name")

docker cp "$profiler_path/$profiler_dir" "$hostname":/profiler

