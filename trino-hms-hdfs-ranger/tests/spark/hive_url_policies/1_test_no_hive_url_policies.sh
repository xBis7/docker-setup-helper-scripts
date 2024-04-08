#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will not have Write permission for Hive URL policy"
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "create table $TABLE_PERSONS (id int, name string)")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [WRITE] privilege on [[hdfs://namenode/opt/hive/data/$TABLE_PERSONS, hdfs://namenode/opt/hive/data/$TABLE_PERSONS/]]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
