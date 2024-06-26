#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
setup_env=$2
stop_env=$3

if [ "$setup_env" == "true" ]; then
  ./setup/setup_for_trino_spark_testing.sh "$abs_path"
fi

./tests/spark/database/1_create_database_no_perms.sh "$abs_path"

./tests/spark/database/2_create_database_hdfs_perms.sh "$abs_path"

./tests/spark/database/3_drop_database_no_perms.sh "$abs_path"

./tests/spark/database/4_create_table_no_hive_perms.sh "$abs_path"

./tests/spark/database/5_create_table_hive_perms.sh "$abs_path"

./tests/spark/database/6_drop_database_no_cascade.sh "$abs_path"

./tests/spark/database/7_drop_database_cascade.sh "$abs_path"

if [ "$stop_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
fi
