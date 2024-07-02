#!/bin/bash

source "./ranger_api/lib.sh"

set -e

prepare_env=$1
abs_path=$2

# Set up the env and load a psql dumb file.
if [ "$prepare_env" == "true" ]; then
  ./setup/setup_for_trino_spark_testing.sh "$abs_path"
fi

# Delete all policies and test that they don't exist anymore.
./ranger_api/delete_policy.sh "hdfs" "all"
checkIfPolicyExists "hdfs" "all"

./ranger_api/delete_policy.sh "hive" "all_db"
checkIfPolicyExists "hive" "all_db"

./ranger_api/delete_policy.sh "hive" "defaultdb"
checkIfPolicyExists "hive" "defaultdb"

./ranger_api/delete_policy.sh "hive" "url"
checkIfPolicyExists "hive" "url"

# Create the policies again with new values and validate the values in the Ranger Admin service.
./ranger_api/create_update/create_update_hdfs_path_policy.sh "create" "read,write:hadoop" "/*"
validateRangerData "hdfs" "all" "read,write:hadoop" "path" "/*"

./ranger_api/create_update/create_update_hive_all_db_policy.sh "create" "select,drop:hadoop/alter,read:spark"
validateRangerData "hive" "all_db" "select,drop:hadoop/alter,read:spark"

./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "create" "select,drop:hadoop/alter,read:spark"
validateRangerData "hive" "defaultdb" "select,drop:hadoop/alter,read:spark"

./ranger_api/create_update/create_update_hive_url_policy.sh "create" "read:spark"
validateRangerData "hive" "url" "read:spark"

# Update all policies with more or less allow conditions and validate the values in the Ranger Admin service.
./ranger_api/create_update/create_update_hdfs_path_policy.sh "put" "read,write:hadoop/execute:spark" "/dir1,/test/*"
validateRangerData "hdfs" "all" "read,write:hadoop/execute:spark" "path" "/dir1,/test/*"

./ranger_api/create_update/create_update_hive_all_db_policy.sh "put" "select,alter:trino"
validateRangerData "hive" "all_db" "select,alter:trino"

./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "put" "select,index,lock:spark" "test_col"
validateRangerData "hive" "defaultdb" "select,index,lock:spark" "column" "test_col"

./ranger_api/create_update/create_update_hive_url_policy.sh "put" "read:spark/write:hadoop"
validateRangerData "hive" "url" "read:spark/write:hadoop"
