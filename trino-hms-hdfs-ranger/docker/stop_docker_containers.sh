#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
project=$2

if [ "$project" == "ranger" ]; then
  handleRangerEnv "$abs_path" "stop"
elif [ "$project" == "hadoop" ]; then
  handleHadoopEnv "$abs_path" "stop"
elif [ "$project" == "hms" ]; then
  handleHiveEnv "$abs_path" "stop"
elif [[ "$project" == "trino" ]]; then
  handleTrinoEnv "$abs_path" "stop"
elif [[ "$project" == "spark" ]]; then
  handleSparkEnv "$abs_path" "stop"
else
  echo "Provided project is unknown."
  echo "Try one of the following: "
  echo "[ranger, hadoop, hms, trino, spark]"
fi
