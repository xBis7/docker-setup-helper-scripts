#!/bin/bash

source "./testlib.sh"

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

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] shouldn't be able to alter table."

command="spark.sql(\"alter table $TABLE_ANIMALS drop partition (name='cow')\")"
expectedMsg="Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_ANIMALS]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] shouldn't be able to alter table."

command="spark.sql(\"insert into $TABLE_SPORTS values(1, 'football')\")"
expectedMsg="Permission denied: user [spark] does not have [ALTER] privilege on [$DEFAULT_DB/$TABLE_SPORTS]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

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
