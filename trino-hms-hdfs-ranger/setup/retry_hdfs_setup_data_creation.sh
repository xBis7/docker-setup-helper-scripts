#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
restart_env=$2

# This script will stop all containers except Ranger. 
# Due to that, we don't need to load the ranger policies again.

if [ "$restart_env" == "y" ]; then
  # Stop the containers.
  # handleTrinoSparkEnv "$abs_path" "stop"
  # handleHiveEnv "$abs_path" "stop"
  handleHadoopEnv "$abs_path" "stop"

  # Start the containers again.
  handleHadoopEnv "$abs_path" "start"
  # handleHiveEnv "$abs_path" "start"
  # handleTrinoSparkEnv "$abs_path" "start"

  sleep 60
fi

if createHdfsTestData "$HDFS_DIR"; then
  echo ""
  echo "- RESULT: HDFS test data creation succeeded."
else
  echo ""
  echo "- RESULT: HDFS test data creation failed."
fi
