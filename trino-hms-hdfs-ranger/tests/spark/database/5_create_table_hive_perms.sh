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
testFileName="5_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/database/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
