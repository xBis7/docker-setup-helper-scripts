#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
component=$2
test_drop_db=$3
prepare_env=$4
stop_env=$5

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path"
fi

echo "### TEST_1 ###"
./tests/test_hdfs_data_creation.sh "$abs_path"

if [ "$component" == "spark" ]; then
  echo "### TEST_2 ###"
  ./tests/spark/1_test_spark_no_hdfs_perms.sh "$abs_path"

  echo "### TEST_3 ###"
  ./tests/spark/2_test_spark_hdfs_perms_no_hive_perms.sh "$abs_path"

  echo "### TEST_4 ###"
  ./tests/spark/3_test_spark_hdfs_hive_all.sh "$abs_path"

  echo "### TEST_5 ###"
  ./tests/spark/4_test_spark_only_select_perm.sh "$abs_path"

  echo "### TEST_6 ###"
  ./tests/spark/5_test_spark_select_alter_perm.sh "$abs_path"

  echo "### TEST_7 ###"
  ./tests/spark/6_test_spark_no_drop_table_perm.sh "$abs_path"

  echo "### TEST_8 ###"
  ./tests/spark/7_test_spark_drop_table_perm.sh "$abs_path"
else
  echo "### TEST_2 ###"
  ./tests/trino/1_test_trino_no_hdfs_perms.sh "$abs_path"

  echo "### TEST_3 ###"
  ./tests/trino/2_test_trino_hdfs_perms_no_hive_perms.sh "$abs_path"

  echo "### TEST_4 ###"
  ./tests/trino/3_test_trino_hdfs_hive_all.sh "$abs_path"

  echo "### TEST_5 ###"
  ./tests/trino/4_test_trino_only_select_perm.sh "$abs_path"

  echo "### TEST_6 ###"
  ./tests/trino/5_test_trino_select_alter_perm.sh "$abs_path"
fi

if [ "$test_drop_db" == "true" ]; then
  # This will restart the environment and setup the necessary files for testing.
  # There is also a flag for stopping the env at the end.
  # Not setting that here because this script will stop the env anyway.
  ./tests/spark/database/test_database.sh "$abs_path" "true"
fi

if [ "$stop_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
fi
