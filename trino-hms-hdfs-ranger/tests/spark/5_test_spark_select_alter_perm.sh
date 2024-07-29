#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have [select, alter] access to Hive default DB."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,alter:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Rename table."
echo "- INFO: User [spark] should be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $DEFAULT_DB.$SPARK_TABLE rename to $DEFAULT_DB.$NEW_SPARK_TABLE_NAME")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] should be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "alter table $TABLE_ANIMALS drop partition (name='cow')")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] should be able to alter table."
cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
scala_sql=$(base64encode "insert into $TABLE_SPORTS values(2, 'basketball')")
retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"

# Failing for Spark-Hive4
# Operation not allowed: TRUNCATE TABLE on external tables: `spark_catalog`.`default`.`sports`.
if [ "$HIVE_VERSION" != "4" ]; then
  echo ""
  echo "- INFO: Truncate table."
  echo "- INFO: User [spark] should be able to alter table."
  cpSparkTest $(pwd)/$SPARK_TEST_PATH/$SPARK_TEST_NO_EXCEPTION_FILENAME
  scala_sql=$(base64encode "truncate table $TABLE_SPORTS")
  retryOperationIfNeeded "$abs_path" "runSparkTest $SPARK_TEST_NO_EXCEPTION_FILENAME $scala_sql" "$SPARK_TEST_SUCCESS_MSG" "false"
fi
