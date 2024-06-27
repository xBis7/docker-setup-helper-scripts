#!/bin/bash

set -e

abs_path=$1
project=$2
spark_workers_num=$3

./docker/stop_docker_containers.sh "$abs_path" "$project"
./docker/start_docker_containers.sh "$abs_path" "$project" "$spark_workers_num"
