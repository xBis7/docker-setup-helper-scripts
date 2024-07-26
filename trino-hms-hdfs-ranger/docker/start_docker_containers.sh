#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
project=$2
spark_workers_num=$3

if [ "$project" == "ranger" ]; then
  handleRangerEnv "$abs_path" "start"
elif [ "$project" == "hadoop" ]; then
  handleHadoopEnv "$abs_path" "start"
elif [ "$project" == "hms" ]; then
  handleHiveEnv "$abs_path" "start"
elif [[ "$project" == "trino" ]]; then
  handleTrinoEnv "$abs_path" "start"
elif [[ "$project" == "spark" ]]; then
  handleSparkEnv "$abs_path" "start" "$spark_workers_num"
elif [[ "$project" == "kerberos" ]]; then
  handleKerberosEnv "$abs_path" "start"
else
  echo "Provided project is unknown."
  echo "Try one of the following: "
  echo "[ranger, hadoop, hms, trino, spark, kerberos]"
fi
