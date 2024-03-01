#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# All environments are using Ranger's network.
# Ranger was started first but now we need to stop it
# last so that the network will be properly removed.

handleSparkEnv "$abs_path" "stop"

handleTrinoEnv "$abs_path" "stop"

handleHiveEnv "$abs_path" "stop"

handleHadoopEnv "$abs_path" "stop"

handleRangerEnv "$abs_path" "stop"

# if docker network rm shared-network; then
#   echo "Removing 'shared-network' succeeded."
# else
#   echo "Removing 'shared-network' failed."
#   echo "Retry manually by running: "
#   echo "> docker network rm shared-network"
# fi

