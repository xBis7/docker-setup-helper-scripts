#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have only [select] access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"
waitForPoliciesUpdate

echo ""
echo "- INFO: Select from table."
echo "- INFO: User [spark] should be able to select from table."
testFileName="4_1_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Rename table."
echo "- INFO: User [spark] shouldn't be able to alter table."
testFileName="4_2_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] shouldn't be able to alter table."
testFileName="4_3_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] shouldn't be able to alter table."
testFileName="4_4_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

echo ""
echo "- INFO: Truncate table."
echo "- INFO: User [spark] shouldn't be able to alter table."
testFileName="4_5_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
