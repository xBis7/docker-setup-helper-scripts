#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
op=$2

./docker/stop_docker_containers.sh "$abs_path" "apacheds"
./docker/stop_docker_containers.sh "$abs_path" "ranger"

# ./setup/setup_docker_env.sh "$abs_path"

if [ "$op" == "start" ]; then
  ./docker/start_docker_containers.sh "$abs_path" "ranger"
  ./docker/start_docker_containers.sh "$abs_path" "apacheds"
fi

# echo ""
# echo "- INFO: Updating Ranger policies."
# ./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"
# waitForPoliciesUpdate
