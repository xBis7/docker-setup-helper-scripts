#!/bin/bash

source "./testlib.sh"

abs_path=$1

# Hadoop depends on the Ranger network and 
# Hive and Trino depend on the Hadoop network.

# The environments need to be started in this particular order
# 1. Ranger
# 2. Hadoop
# 3. Hive
# 4. Trino

if docker network create shared-network; then
  echo "Creating 'shared-network' succeeded."
else
  echo "Creating 'shared-network' failed."
  echo "Retry manually by running: "
  echo "> docker network create shared-network"
fi

handleRangerEnv "$abs_path" "start"

handleHadoopEnv "$abs_path" "start"

handleHiveEnv "$abs_path" "start"

handleTrinoSparkEnv "$abs_path" "start"
