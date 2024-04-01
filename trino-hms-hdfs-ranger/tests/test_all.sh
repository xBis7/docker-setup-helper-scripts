#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
component=$2
prepare_env=$3
stop_env=$4

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path"
fi

echo ""
echo "### TEST_1 ###"
./tests/test_hdfs_data_creation.sh "$abs_path"

if [ "$component" == "spark" ]; then
  echo ""
  echo "### TEST_2 ###"
  ./tests/spark/1_test_spark_no_hdfs_perms.sh "$abs_path"

  echo ""
  echo "### TEST_DATABASE ###"
  # This script contains multiple tests and can be run independently.
  # We already have the correct setup and therefore, 
  # no flags regarding the docker env, will be used.
  ./tests/spark/database/test_database.sh "$abs_path"

  echo ""
  echo "### TEST_3 ###"
  ./tests/spark/2_test_spark_hdfs_perms_no_hive_perms.sh "$abs_path"

  echo ""
  echo "### TEST_4 ###"
  ./tests/spark/3_test_spark_hdfs_hive_all.sh "$abs_path"

  echo ""
  echo "### TEST_5 ###"
  ./tests/spark/4_test_spark_only_select_perm.sh "$abs_path"

  echo ""
  echo "### TEST_6 ###"
  ./tests/spark/5_test_spark_select_alter_perm.sh "$abs_path"

  echo ""
  echo "### TEST_7 ###"
  ./tests/spark/6_test_spark_no_drop_table_perm.sh "$abs_path"

  echo ""
  echo "### TEST_8 ###"
  ./tests/spark/7_test_spark_drop_table_perm.sh "$abs_path"
else
  echo ""
  echo "### TEST_2 ###"
  ./tests/trino/1_test_trino_no_hdfs_perms.sh "$abs_path"

  echo ""
  echo "### TEST_SCHEMA ###"
  # A database in Trino is considered a schema.
  # Same as 'spark/database/test_database.sh' but for trino.
  ./tests/trino/schema/test_schema.sh "$abs_path" "true"

  echo ""
  echo "### TEST_3 ###"
  ./tests/trino/2_test_trino_hdfs_perms_no_hive_perms.sh "$abs_path"

  echo ""
  echo "### TEST_4 ###"
  ./tests/trino/3_test_trino_hdfs_hive_all.sh "$abs_path"

  echo ""
  echo "### TEST_5 ###"
  ./tests/trino/4_test_trino_only_select_perm.sh "$abs_path"

  echo ""
  echo "### TEST_6 ###"
  ./tests/trino/5_test_trino_select_alter_perm.sh "$abs_path"

  echo ""
  echo "### TEST_7 ###"
   ./tests/trino/6_test_trino_no_drop_table_perm.sh "$abs_path"

  echo ""
  echo "### TEST_8 ###"
  ./tests/trino/7_test_trino_drop_table_perm.sh "$abs_path"
fi

if [ "$stop_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
fi

echo "Testing Hive URL policies"
./tests/test_hive_url_policies.sh "$abs_path" "$component" "$prepare_env" "$stop_env"