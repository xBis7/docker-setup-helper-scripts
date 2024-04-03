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
testFileName="1_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/hive_url_policies/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
