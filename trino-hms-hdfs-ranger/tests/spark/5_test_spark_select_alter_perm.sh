#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have [select, alter] access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"
waitForPoliciesUpdate

echo ""
echo "- INFO: Rename table."
echo "- INFO: User [spark] should be able to alter table."
testFileName="5_1_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] should be able to alter table."
testFileName="5_2_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] should be able to alter table."
testFileName="5_3_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Truncate table."
echo "- INFO: User [spark] should be able to alter table."
testFileName="5_4_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
