#!/bin/bash

source "./testlib.sh"

abs_path=$1
project=$2

if [ "$project" == "ranger" ]; then
  handleRangerEnv "$abs_path" "stop"
elif [ "$project" == "hadoop" ]; then
  handleHadoopEnv "$abs_path" "stop"
elif [ "$project" == "hive" ]; then
  handleHiveEnv "$abs_path" "stop"
elif [[ "$project" == "trino" || "$project" == "spark" ]]; then
  handleTrinoSparkEnv "$abs_path" "stop"
else
  echo "Provided project is unknown."
  echo "Try one of the following: "
  echo "[ranger, hadoop, hive, trino, spark]"
fi
