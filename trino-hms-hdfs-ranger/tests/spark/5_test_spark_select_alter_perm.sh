#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

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

command="spark.sql(\"alter table $DEFAULT_DB.$SPARK_TABLE rename to $DEFAULT_DB.$NEW_SPARK_TABLE_NAME\")"
runSpark "spark" "$command" "shouldPass"

echo ""
echo "- INFO: Drop partition."
echo "- INFO: User [spark] should be able to alter table."

command="spark.sql(\"alter table $TABLE_ANIMALS drop partition (name='cow')\")"
runSpark "spark" "$command" "shouldPass"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] should be able to alter table."

command="spark.sql(\"insert into $TABLE_SPORTS values(2, 'basketball')\")"
runSpark "spark" "$command" "shouldPass"

# Failing for Spark-Hive4
# Operation not allowed: TRUNCATE TABLE on external tables: `spark_catalog`.`default`.`sports`.
if [ "$HIVE_VERSION" != "4" ]; then
  echo ""
  echo "- INFO: Truncate table."
  echo "- INFO: User [spark] should be able to alter table."

  command="spark.sql(\"truncate table $TABLE_SPORTS\")"
  runSpark "spark" "$command" "shouldPass"
fi
