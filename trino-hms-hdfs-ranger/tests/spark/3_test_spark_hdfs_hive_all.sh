#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive default DB."
./setup/load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"
waitForPoliciesUpdate

# echo ""
# echo "- INFO: Create table."
# echo "- INFO: User [spark] should be able to create table."
# testFileName="3_1_test.scala"
# cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
# successMsg="Test passed"
# retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName $successMsg" "$successMsg" "false"

echo ""
echo "- INFO: Create partitioned table."
echo "- INFO: User [spark] should be able to create table."
testFileName="3_2_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName

# We can achieve the correct variable substitution and space handling by encoding and decoding the string.
# -w 0, makes sure that the line length is ignored.
scala_sql=$(echo -n 'create table animals (id int, name string) using parquet partitioned by (name)' | base64 -w 0)
scala_msg=$(echo -n 'empty' | base64 -w 0)
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName $scala_sql $scala_msg" "$successMsg" "false"

# echo ""
# echo "- INFO: Add partition."
# echo "- INFO: User [spark] should be able to alter table."
# testFileName="3_3_test.scala"
# cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
# retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

# echo ""
# echo "- INFO: Create non partitioned table."
# echo "- INFO: User [spark] should be able to create table."
# testFileName="3_4_test.scala"
# cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
# retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"

# echo ""
# echo "- INFO: Insert into table."
# echo "- INFO: User [spark] should be able to alter table."
# testFileName="3_5_test.scala"
# cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
# retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
