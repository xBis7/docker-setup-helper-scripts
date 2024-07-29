#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive $EXTERNAL_DB DB."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark,trino"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."

command="spark.read.text(\"hdfs://namenode:8020/test\").write.option(\"path\", \"hdfs://namenode/opt/hive/data\").mode(\"overwrite\").format(\"csv\").saveAsTable(\"$EXTERNAL_DB.$SPARK_TABLE\")"
runSpark "spark" "$command" "shouldPass"
