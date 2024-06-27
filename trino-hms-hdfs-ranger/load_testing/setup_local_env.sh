#!/bin/bash

source "./load_testing/env_variables.sh"
source "./load_testing/lib.sh"

set -e

abs_path=$1

./docker/stop_docker_env.sh "$abs_path"
./setup/setup_docker_env.sh "$abs_path"
./docker/start_docker_env.sh "$abs_path" "true" "4"
createHdfsDir "$HIVE_WAREHOUSE_DIR"

HIVE_BASE_POLICIES="hive_base_policies"

echo ""
echo "- INFO: Updating Ranger policies. Loading base Hive policies. No user will have any access."
./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

waitForPoliciesUpdate
