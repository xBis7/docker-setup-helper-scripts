#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,read:spark"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo "- INFO: Create table."
echo "- INFO: User [spark] shouldn't be able to create table."

command="spark.read.text(\"hdfs://namenode:8020/test\").write.option(\"path\", \"hdfs://namenode/opt/hive/data\").mode(\"overwrite\").format(\"csv\").saveAsTable(\"$DEFAULT_DB.$SPARK_TABLE\")"
expectedMsg="Permission denied: user=spark, access=WRITE"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "spark" "createTable" "$DEFAULT_DB" "$SPARK_TABLE"
