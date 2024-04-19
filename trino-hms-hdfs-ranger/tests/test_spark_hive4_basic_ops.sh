#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path"
fi

echo ""
echo "### TEST_0 ###"
./tests/test_hdfs_data_creation.sh "$abs_path"

echo ""
echo "### TEST_1 ###"
./tests/spark/1_test_spark_no_hdfs_perms.sh "$abs_path"

echo ""
echo "### TEST_2 ###"
./tests/spark/2_test_spark_hdfs_perms_no_hive_perms.sh "$abs_path"

echo ""
echo "### TEST_3 ###"
./tests/spark/3_test_spark_hdfs_hive_all.sh "$abs_path"

echo ""
echo "### TEST_4 ###"
./tests/spark/4_test_spark_only_select_perm.sh "$abs_path"

echo ""
echo "### TEST_5 ###"
./tests/spark/5_test_spark_select_alter_perm.sh "$abs_path"

echo ""
echo "### TEST_6 ###"
./tests/spark/6_test_spark_no_drop_table_perm.sh "$abs_path"

echo ""
echo "### TEST_7 ###"
./tests/spark/7_test_spark_drop_table_perm.sh "$abs_path"
