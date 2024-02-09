#!/bin/bash

source "../testlib.sh"

abs_path=$1

trino_table="test_table"
hdfs_dir="test"

./start_docker_env.sh "$abs_path"

echo "### TEST_1 ###"
./test_hdfs_data_creation.sh "$abs_path"

echo "### TEST_2 ###"
./test_hive_no_hdfs_perm.sh

echo "### TEST_3 ###"
./test_hive_no_perms.sh "$abs_path"

echo "### TEST_4 ###"
./test_hive_all_perms.sh "$abs_path"

echo "### TEST_5 ###"
./test_hive_only_select_perm.sh "$abs_path"

echo "### TEST_6 ###"
./test_hive_select_alter_perm.sh "$abs_path"

./stop_docker_env.sh "$abs_path"
