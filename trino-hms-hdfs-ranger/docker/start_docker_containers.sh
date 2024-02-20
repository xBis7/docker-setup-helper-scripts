#!/bin/bash

source "./testlib.sh"

abs_path=$1
project=$2

if [ "$project" == "ranger" ]; then
  handleRangerEnv "$abs_path" "start"
elif [ "$project" == "hadoop" ]; then
  handleHadoopEnv "$abs_path" "start"
elif [ "$project" == "hms" ]; then
  handleHiveEnv "$abs_path" "start"
elif [[ "$project" == "trino" || "$project" == "spark" ]]; then
  handleTrinoSparkEnv "$abs_path" "start"
else
  echo "Provided project is unknown."
  echo "Try one of the following: "
  echo "[ranger, hadoop, hms, trino, spark]"
fi
