#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

abs_path=$1

./big-data-tests/copy_files_under_spark.sh "$abs_path"

echo ""
echo "## Test 1 ##"
echo "Create a database without having Create permissions"
echo ""

./big-data-tests/spark/1_set_policies.sh

combineFileWithCommonUtilsFile "$TEST1_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER1\" --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE" "$SPARK_USER1"

echo ""
echo "## Test 2 ##"
echo "Create a database without having read,write,execute HDFS permissions"
echo ""

./big-data-tests/spark/2_set_policies.sh

combineFileWithCommonUtilsFile "$TEST2_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER1\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE" "$SPARK_USER1"

echo ""
echo "## Test 3 ##"
echo "Create a database having Create (Hive), read,write,execute (HDFS) and Read and Write (Hive)"
echo ""

./big-data-tests/spark/3_set_policies.sh

combineFileWithCommonUtilsFile "$TEST3_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE" "$SPARK_USER1"

echo ""
echo "## Test 4 ##"
echo "Drop the database as another user (e.g. user2) without access"
echo ""

./big-data-tests/spark/4_set_policies.sh

combineFileWithCommonUtilsFile "$TEST4_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"

echo ""
echo "## Test 5 ##"
echo "Drop the database and recreate using the default Hive warehouse location"
echo ""

./big-data-tests/spark/5_set_policies.sh

combineFileWithCommonUtilsFile "$TEST5_FILE"
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER1\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.db_base_dir=\"/$HIVE_WAREHOUSE_DIR\" -I $TMP_COMBINED_FILE" "$SPARK_USER1"

echo ""
echo "## Test 6 ##"
echo "Create a database using the default hive warehouse location with an HDFS and Hive URL policy present"
echo ""

echo ""
echo "Ensure world read and execute on the Hive Warehouse directory, and create a sub-directory for the new database"
echo ""
changeHdfsDirPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR" 755
# The notes are creating 'testdb.db' but the ranger policies are providing access for 'gross_test.db'
# also the db is named 'gross_test'. Let's assume that 'testdb.db' is a typo.
createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

./big-data-tests/spark/6_set_policies.sh

combineFileWithCommonUtilsFile "$TEST6_FILE"
runScalaFileInSparkShell "bin/spark-shell -I $TMP_COMBINED_FILE" "$SPARK_USER1"

