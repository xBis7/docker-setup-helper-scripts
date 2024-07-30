#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [spark] will now have all access to Hive default DB."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Create table."
echo "- INFO: User [spark] should be able to create table."

command="spark.read.text(\"hdfs://namenode:8020/test\").write.option(\"path\", \"hdfs://namenode/opt/hive/data\").mode(\"overwrite\").format(\"csv\").saveAsTable(\"$DEFAULT_DB.$SPARK_TABLE\")"
runSpark "spark" "$command" "shouldPass"

echo ""
echo "- INFO: Create partitioned table."
echo "- INFO: User [spark] should be able to create table."

command="spark.sql(\"create table $TABLE_ANIMALS (id int, name string) using parquet partitioned by (name)\")"
runSpark "spark" "$command" "shouldPass"

echo ""
echo "- INFO: Add partition."
echo "- INFO: User [spark] should be able to alter table."

command="spark.sql(\"alter table $TABLE_ANIMALS add partition (name='cow')\")"
runSpark "spark" "$command" "shouldPass"

echo ""
echo "- INFO: Create non partitioned table."
echo "- INFO: User [spark] should be able to create table."

command="spark.sql(\"create table $TABLE_SPORTS (id int, name string)\")"
runSpark "spark" "$command" "shouldPass"

echo ""
echo "- INFO: Insert into table."
echo "- INFO: User [spark] should be able to alter table."

command="spark.sql(\"insert into $TABLE_SPORTS values(1, 'football')\")"
runSpark "spark" "$command" "shouldPass"
