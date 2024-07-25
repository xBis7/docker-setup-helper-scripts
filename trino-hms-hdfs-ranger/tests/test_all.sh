#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1
component=$2
prepare_env=$3
stop_env=$4

if [ "$component" != "spark" ] && [ "$component" != "trino" ]; then
  echo ""
  echo "Invalid component name. Try one of the following: 'spark', 'trino'."
  echo "Exiting..."
  echo ""
  exit 1
fi

if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path"
fi

./big-data-c3-tests/copy_files_under_spark.sh "$abs_path"

./setup/load_ranger_policies.sh "$abs_path" "$HIVE_BASE_POLICIES"

waitForPoliciesUpdate

echo ""
echo "### TEST_hdfs_data_creation ###"
./tests/test_hdfs_data_creation.sh

echo ""
echo """### TEST_"$component"_no_hdfs_perms ###"""
./tests/"$component"/1_test_"$component"_no_hdfs_perms.sh

# if [ "$component" == "spark" ]; then
#   echo ""
#   echo "### TEST_DATABASE ###"
#   # This script contains multiple tests and can be run independently.
#   # We already have the correct setup and therefore, 
#   # no flags regarding the docker env, will be used.
#   ./tests/"$component"/database/test_database.sh "$abs_path"
# else
#   echo ""
#   echo "### TEST_SCHEMA ###"
#   # A database in Trino is considered a schema.
#   # Same as 'spark/database/test_database.sh' but for trino.
#   ./tests/"$component"/schema/test_schema.sh "$abs_path" "true"
# fi

echo ""
echo """### TEST_"$component"_hdfs_perms_no_hive_perms ###"""
./tests/"$component"/2_test_"$component"_hdfs_perms_no_hive_perms.sh

echo ""
echo """### TEST_"$component"_hdfs_hive_all ###"""
./tests/"$component"/3_test_"$component"_hdfs_hive_all.sh

echo ""
echo """### TEST_"$component"_only_select_perm ###"""
./tests/"$component"/4_test_"$component"_only_select_perm.sh

echo ""
echo """### TEST_"$component"_select_alter_perm ###"""
./tests/"$component"/5_test_"$component"_select_alter_perm.sh

echo ""
echo """### TEST_"$component"_no_drop_table_perm ###"""
./tests/"$component"/6_test_"$component"_no_drop_table_perm.sh

echo ""
echo """### TEST_"$component"_drop_table_perm ###"""
./tests/"$component"/7_test_"$component"_drop_table_perm.sh

echo ""
echo """### TEST_"$component"_no_select_perm ###"""
./tests/"$component"/8_test_"$component"_no_select_perm.sh

echo ""
echo "Testing Hive URL policies"
./tests/test_hive_url_policies.sh "$abs_path" "$component" "$prepare_env" "$stop_env"
