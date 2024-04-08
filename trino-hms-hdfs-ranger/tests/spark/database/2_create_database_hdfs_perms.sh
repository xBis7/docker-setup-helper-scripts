#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: There will be no Hive permissions."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"
waitForPoliciesUpdate

echo "- INFO: Create database."
echo "- INFO: User [spark] should be able to create database."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "create database $EXTERNAL_DB location 'hdfs://namenode/opt/hive/data/$EXTERNAL_DB/external/$EXTERNAL_DB.db'")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
