#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [spark] now will have [ALL] privileges on all HDFS paths."
echo "- INFO: No user will have permissions on Hive metastore operations on the default db."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."

command="spark.read.text(\"hdfs://namenode:8020/test\").write.option(\"path\", \"hdfs://namenode/opt/hive/data\").mode(\"overwrite\").format(\"csv\").saveAsTable(\"$DEFAULT_DB.$SPARK_TABLE\")"
expectedMsg="Permission denied: user [spark] does not have [CREATE] privilege on [$DEFAULT_DB/$SPARK_TABLE]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"