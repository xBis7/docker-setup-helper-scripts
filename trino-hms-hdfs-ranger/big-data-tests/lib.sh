#!/bin/bash

set -e

source "./big-data-tests/env_variables.sh"


createHdfsDir() {
  dir_name=$1

  hdfs_cmd="hdfs dfs -mkdir -p /$dir_name"

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it "$DN1_HOSTNAME" bash -c "$hdfs_cmd"
  else
    echo "Implement this."
  fi  
}

runScalaFileInSparkShell() {
  spark_shell_cmd=$1

  if [ "$CURRENT_ENV" == "local" ]; then
    docker exec -it -u spark "$SPARK_MASTER_HOSTNAME" bash -c "$spark_shell_cmd"
  else
    echo "Implement this."
  fi
}