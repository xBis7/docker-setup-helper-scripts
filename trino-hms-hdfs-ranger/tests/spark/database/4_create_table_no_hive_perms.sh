#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: User [spark] has no Hive perms. Creating a table under db '$EXTERNAL_DB' should fail."
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."
testFileName="4_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/database/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
