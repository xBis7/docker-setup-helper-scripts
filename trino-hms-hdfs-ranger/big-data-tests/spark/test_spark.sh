#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

abs_path=$1
spark_user1=$2

./big-data-tests/copy_files_under_spark.sh "$abs_path"

echo ""
echo "## Test 1 ##"
echo "Create a database without having Create permissions"
echo ""

./big-data-tests/spark/1_set_policies.sh "hadoop" "postgres" "$spark_user1"

combineFileWithCommonUtilsFile "$TEST1_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$spark_user1\" --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE"

echo ""
echo "## Test 2 ##"
echo "Create a database without having read,write,execute HDFS permissions"
echo ""

./big-data-tests/spark/2_set_policies.sh "hadoop" "postgres" "$spark_user1"

combineFileWithCommonUtilsFile "$TEST2_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$spark_user1\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE"

echo ""
echo "## Test 3 ##"
echo "Create a database having Create (Hive), read,write,execute (HDFS) and Read and Write (Hive)"
echo ""

./big-data-tests/spark/3_set_policies.sh "hadoop" "postgres" "$spark_user1"

combineFileWithCommonUtilsFile "$TEST3_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE"
