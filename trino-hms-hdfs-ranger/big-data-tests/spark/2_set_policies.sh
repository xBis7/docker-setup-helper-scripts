#!/bin/bash

source "./big-data-tests/lib.sh"

set -e

hdfs_user=$1
hive_user=$2
spark_user=$3

./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:$hdfs_user,$hive_user" "put"

./ranger_api/create_update/create_update_hive_all_db_policy.sh "alter,create,drop,index,lock,select,update:$hive_user,$spark_user" "put" "gross_test"

./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select:$hive_user,$spark_user" "put"

./ranger_api/create_update/create_update_hive_url_policy.sh "read:$spark_user" "put"

waitForPoliciesUpdate
