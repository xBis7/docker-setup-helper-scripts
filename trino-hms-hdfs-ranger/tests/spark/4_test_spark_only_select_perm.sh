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
scala_sql=$(base64encode "select * from $DEFAULT_DB.$SPARK_TABLE")
retryOperationIfNeeded "$abs_path" "runSparkTest $test_file_name $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Rename table."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $DEFAULT_DB.$SPARK_TABLE rename to $DEFAULT_DB.$NEW_SPARK_TABLE_NAME")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$SPARK_TABLE]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $TABLE_ANIMALS drop partition (name='cow')")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_ANIMALS]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "insert into $TABLE_SPORTS values(1, 'football')")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_SPORTS]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"

# This was failing for Spark-Hive4. Adding the property below in the hive-site.xml fixed it.
#   <property>
#     <name>metastore.metadata.transformer.class</name>
#     <value> </value>
#   </property>

# Simple 'CREATE TABLE' commands should create a managed table but for Hive4 that's not the case.
# 'DESCRIBE FORMATTED table' is showing 'Table Properties -> TRANSLATED_TO_EXTERNAL'
# and the table is treated as if it is non-managed.

# That unexpected behavior is caused by the transformer according to these references
# and the current workaround is to disable it.
# Check ticket description: https://issues.apache.org/jira/browse/HIVE-24954
# Check ticket comments: https://issues.apache.org/jira/browse/HIVE-28198
echo ""
echo "- INFO: Truncate table."
echo "- INFO: User [spark] shouldn't be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_FOR_EXCEPTION_FILENAME
scala_sql=$(base64encode "truncate table $TABLE_SPORTS")
scala_msg=$(base64encode "Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_SPORTS]")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_FOR_EXCEPTION_FILENAME $scala_sql $scala_msg" "$SPARK_TEST_SUCCESS_MSG" "false"
