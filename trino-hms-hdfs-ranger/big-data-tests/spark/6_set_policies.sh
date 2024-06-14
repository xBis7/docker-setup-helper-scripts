#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

./ranger_api/create_update/create_update_hdfs_path_policy.sh "/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$HDFS_USER,$SPARK_USER1" "put"

./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:$SPARK_USER1" "put" "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate
