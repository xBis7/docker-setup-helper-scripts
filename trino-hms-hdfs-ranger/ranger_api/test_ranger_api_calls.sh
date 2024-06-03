#!/bin/bash

source "./ranger_api/lib.sh"

set -e

prepare_env=$1
abs_path=$2

# Set up the env and load a psql dumb file.
if [ "$prepare_env" == "true" ]; then
  ./setup/setup_for_trino_spark_testing.sh "$abs_path"
fi

# Delete all policies.
checkApiCallStatusCode "./ranger_api/delete_policy.sh hdfs all" "hdfs           - delete"

checkApiCallStatusCode "./ranger_api/delete_policy.sh hive all_db" "hive_db        - delete"

checkApiCallStatusCode "./ranger_api/delete_policy.sh hive defaultdb" "hive_defaultdb - delete"

checkApiCallStatusCode "./ranger_api/delete_policy.sh hive url" "hive_url       - delete"

# Create the policies again with new values.
checkApiCallStatusCode "./ranger_api/create_update/create_update_hdfs_path_policy.sh '/*' read,write:hadoop create" "hdfs           - create"

checkApiCallStatusCode "./ranger_api/create_update/create_update_hive_all_db_policy.sh select,drop:hadoop/alter,read:spark create" "hive_db        - create"

checkApiCallStatusCode "./ranger_api/create_update/create_update_hive_defaultdb_policy.sh select,drop:hadoop/alter,read:spark create" "hive_defaultdb - create"

checkApiCallStatusCode "./ranger_api/create_update/create_update_hive_url_policy.sh read:spark create" "hive_url       - create"

# Update all policies with more or less allow conditions.
checkApiCallStatusCode "./ranger_api/create_update/create_update_hdfs_path_policy.sh '/dir1,/test/*' read,write:hadoop/execute:spark put" "hdfs           - update"

checkApiCallStatusCode "./ranger_api/create_update/create_update_hive_all_db_policy.sh select,alter:trino put" "hive_db        - update"

checkApiCallStatusCode "./ranger_api/create_update/create_update_hive_defaultdb_policy.sh select,index,lock:spark put test_col" "hive_defaultdb - update"

checkApiCallStatusCode "./ranger_api/create_update/create_update_hive_url_policy.sh read:spark/write:hadoop put" "hive_url       - update"
