#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have only [select] access to Hive default DB."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Select from table."
echo "- INFO: User [spark] should be able to select from table."

command="spark.sql(\"select * from $DEFAULT_DB.$SPARK_TABLE\").show(true)"
expectedMsg="|  1, dog|"
runSpark "spark" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "- INFO: Rename table."
echo "- INFO: User [spark] shouldn't be able to alter table."

command="spark.sql(\"alter table $DEFAULT_DB.$SPARK_TABLE rename to $DEFAULT_DB.$NEW_SPARK_TABLE_NAME\")"
expectedMsg="Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$SPARK_TABLE]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "spark" "renameTable" "$DEFAULT_DB" "$SPARK_TABLE"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] shouldn't be able to alter table."

command="spark.sql(\"alter table $TABLE_ANIMALS drop partition (name='cow')\")"
expectedMsg="Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_ANIMALS]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] shouldn't be able to alter table."

command="spark.sql(\"insert into $TABLE_SPORTS values(2, 'soccer')\")"
expectedMsg="Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_SPORTS]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

# 'insertInto' writes the data and then alters the table.
# Because the user only lacks alter permissions, although we get an exception, the data have already been written.
# The check doesn't make sense here because the data will exist.
#
# verifyCreateWriteFailure "spark" "insertInto" "$DEFAULT_DB" "$TABLE_SPORTS" "2"

# Failing for Spark-Hive4
# Operation not allowed: TRUNCATE TABLE on external tables: `spark_catalog`.`default`.`sports`.
if [ "$HIVE_VERSION" != "4" ]; then
  echo ""
  echo "- INFO: Truncate table."
  echo "- INFO: User [spark] shouldn't be able to alter table."

  command="spark.sql(\"truncate table $TABLE_SPORTS\")"
  expectedMsg="Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_SPORTS]"
  runSpark "spark" "$command" "shouldFail" "$expectedMsg"
fi
