#!/bin/bash

source "./testlib.sh"

abs_path=$1

# All environments are using Ranger's network. Ranger needs to start first.

# if docker network create shared-network; then
#   echo "Creating 'shared-network' succeeded."
# else
#   echo "Creating 'shared-network' failed."
#   echo "Retry manually by running: "
#   echo "> docker network create shared-network"
# fi

handleRangerEnv "$abs_path" "start"

handleHadoopEnv "$abs_path" "start"

handleHiveEnv "$abs_path" "start"

handleTrinoSparkEnv "$abs_path" "start"
