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
test_file_name="4_1_test.scala"
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$test_file_name
scala_sql=$(base64encode "select * from default.spark_test_table")
retryOperationIfNeeded "$abs_path" "runSparkTest $test_file_name $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Rename table."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table default.spark_test_table rename to default.new_spark_test_table")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [default/spark_test_table]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table animals drop partition (name='cow')")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [default/animals]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "insert into sports values(1, 'football')")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [default/sports]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Truncate table."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "truncate table sports")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [default/sports]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
