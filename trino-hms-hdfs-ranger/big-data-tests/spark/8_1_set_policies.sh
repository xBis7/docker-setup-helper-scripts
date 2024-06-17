#!/bin/bash

set -e

./ranger_api/create_update/create_update_hdfs_path_policy.sh "/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$HDFS_USER,$SPARK_USER1/read,execute:$SPARK_USER2" "put"

waitForPoliciesUpdate
