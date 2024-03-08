#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
setup_env=$2
stop_env=$3

if [ "$setup_env" == "true" ]; then
  ./setup/setup_for_trino_spark_testing.sh "$abs_path"
fi

echo ""
echo "- INFO: Trino treats databases as schemas." 
echo "- INFO: It's the same thing but different terminology."
echo ""

./tests/trino/schema/1_create_schema_no_perms.sh "$abs_path"

./tests/trino/schema/2_create_schema_hdfs_perms.sh "$abs_path"

./tests/trino/schema/3_drop_schema_no_perms.sh "$abs_path"

./tests/trino/schema/4_create_table_no_hive_perms.sh "$abs_path"

./tests/trino/schema/5_create_table_hive_perms.sh "$abs_path"

./tests/trino/schema/6_drop_schema_no_cascade.sh "$abs_path"

./tests/trino/schema/7_drop_schema_cascade.sh "$abs_path"

if [ "$stop_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
fi
