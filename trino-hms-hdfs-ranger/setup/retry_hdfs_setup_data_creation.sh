#!/bin/bash

source "./testlib.sh"

abs_path=$1

# This script will stop all containers except Ranger. 
# Due to that, we don't need to load the ranger policies again.

# Stop the containers.
# handleTrinoSparkEnv "$abs_path" "stop"
# handleHiveEnv "$abs_path" "stop"
handleHadoopEnv "$abs_path" "stop"

# Start the containers again.
handleHadoopEnv "$abs_path" "start"
# handleHiveEnv "$abs_path" "start"
# handleTrinoSparkEnv "$abs_path" "start"

sleep 30

if createHdfsTestData "$HDFS_DIR"; then
  echo ""
  echo "- RESULT: HDFS test data creation succeeded."
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."
fi
