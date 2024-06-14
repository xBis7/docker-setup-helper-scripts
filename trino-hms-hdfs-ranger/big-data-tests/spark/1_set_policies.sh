#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:$HDFS_USER,$HIVE_USER,$SPARK_USER1" "put"

./ranger_api/create_update/create_update_hive_all_db_policy.sh "select:$HIVE_USER,$SPARK_USER1" "put"

./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select:$HIVE_USER,$SPARK_USER1" "put"

./ranger_api/create_update/create_update_hive_url_policy.sh "read:$SPARK_USER1" "put"

waitForPoliciesUpdate
