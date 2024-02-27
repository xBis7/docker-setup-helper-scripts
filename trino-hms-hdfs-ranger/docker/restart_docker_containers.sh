#!/bin/bash

set -e

abs_path=$1
project=$2

./docker/stop_docker_containers.sh "$abs_path" "$project"
./docker/start_docker_containers.sh "$abs_path" "$project"
