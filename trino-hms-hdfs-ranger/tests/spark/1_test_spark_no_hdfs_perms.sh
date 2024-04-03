#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
testFileName="1_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
