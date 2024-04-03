#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo "- INFO: Reusing policies."
echo "- INFO: To create an external Database and store it in HDFS, using Spark,"
echo "- INFO: all you need is HDFS perms. No Hive perms are needed."
echo "- INFO: User [spark] doesn't have HDFS or Hive permissions."
echo "- INFO: Create database."
echo "- INFO: User [spark] shouldn't be able to create database."
testFileName="1_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/database/$testFileName
successMsg="Test passed"
retryOperationIfNeeded "$abs_path" "runSparkTest $testFileName" "$successMsg" "false"
