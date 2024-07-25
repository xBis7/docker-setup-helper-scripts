#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: User [spark] has only 'select' Hive perms. Creating a table under db '$EXTERNAL_DB' should fail."
echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive/select,read:spark,trino"
updateHiveDefaultDbPolicy "select,read:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

command="spark.read.text(\"hdfs://namenode:8020/test\").write.option(\"path\", \"hdfs://namenode/opt/hive/data\").mode(\"overwrite\").format(\"csv\").saveAsTable(\"$EXTERNAL_DB.$SPARK_TABLE\")"
expectedMsg="Permission denied: user [spark] does not have [CREATE] privilege on [$EXTERNAL_DB/$SPARK_TABLE]"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"
