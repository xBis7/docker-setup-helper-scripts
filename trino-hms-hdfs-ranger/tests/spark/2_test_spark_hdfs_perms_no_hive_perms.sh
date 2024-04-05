#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: No user will have permissions on Hive metastore operations on the default db."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_ACCESS"
waitForPoliciesUpdate

echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME
scala_sql=$(echo -n "default.spark_test_table" | base64)
scala_msg=$(echo -n "Permission denied: user [spark] does not have [CREATE] privilege on [default/spark_test_table]" | base64)
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
