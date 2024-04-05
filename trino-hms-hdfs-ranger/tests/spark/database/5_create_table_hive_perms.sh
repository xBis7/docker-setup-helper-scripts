#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive $EXTERNAL_DB DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_EXT_DB_ALL"
waitForPoliciesUpdate

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "$EXTERNAL_DB.$SPARK_TABLE")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_EXTERNAL_TABLE_CREATION_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
