#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR" # This isn't called with retryOperationIfNeeded and it won't print any descriptive output.
fi

echo ""
echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_BASE_POLICIES"
sleep 15


