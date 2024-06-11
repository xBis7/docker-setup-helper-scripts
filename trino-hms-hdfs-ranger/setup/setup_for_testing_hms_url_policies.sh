#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

# This script is useful for manual testing.
# It sets up the environment with Hive URL policies enabled and
# sets the minimum policies needed.

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR" # This isn't called with retryOperationIfNeeded and it won't print any descriptive output.
fi

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will have Write permission for Hive URL policy but no HDFS access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_NO_HDFS"
sleep 15

