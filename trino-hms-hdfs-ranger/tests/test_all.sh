#!/bin/bash

source "./testlib.sh"

abs_path=$1

./docker/start_docker_env.sh "$abs_path"

echo "### TEST_1 ###"
./test/test_hdfs_data_creation.sh "$abs_path"

echo "### TEST_2 ###"
./test/test_hive_no_hdfs_perm.sh

echo "### TEST_3 ###"
./test/test_hive_no_perms.sh "$abs_path"

echo "### TEST_4 ###"
./test/test_hive_all_perms.sh "$abs_path"

echo "### TEST_5 ###"
./test/test_hive_only_select_perm.sh "$abs_path"

echo "### TEST_6 ###"
./test/test_hive_select_alter_perm.sh "$abs_path"

./docker/stop_docker_env.sh "$abs_path"
