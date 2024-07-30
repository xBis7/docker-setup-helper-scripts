#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

# 'setup_for_trino_spark_testing' is setting up '$HIVE_BASE_POLICIES'.
# We don't need to repeat it here.
./setup/setup_for_trino_spark_testing.sh "$abs_path"

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:trino,spark"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
sleep 15

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."

command="spark.read.text(\"hdfs://namenode:8020/test\").write.option(\"path\", \"hdfs://namenode/opt/hive/data\").mode(\"overwrite\").format(\"csv\").saveAsTable(\"$DEFAULT_DB.$SPARK_TABLE\")"
runSpark "spark" "$command" "shouldPass"

command="create table hive.$DEFAULT_DB.$TRINO_TABLE (column1 varchar,column2 varchar) with (external_location = 'hdfs://namenode/$HDFS_DIR',format = 'CSV');"
expectedMsg="CREATE TABLE"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"
