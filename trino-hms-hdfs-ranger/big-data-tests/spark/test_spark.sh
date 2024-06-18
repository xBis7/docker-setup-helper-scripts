#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

abs_path=$1

./big-data-tests/copy_files_under_spark.sh "$abs_path"

# c3 - TODO.
# kinit

./big-data-tests/spark/test_1.sh

./big-data-tests/spark/test_2.sh

./big-data-tests/spark/test_3.sh

# echo ""
# echo "## Test 4 ##"
# echo "Drop the database as another user (e.g. user2) without access"
# echo ""

# ./big-data-tests/spark/4_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST4_FILE"
# runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"

# echo ""
# echo "## Test 5 ##"
# echo "Drop the database and recreate using the default Hive warehouse location"
# echo ""

# ./big-data-tests/spark/5_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST5_FILE"
# runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER1\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.db_base_dir=\"/$HIVE_WAREHOUSE_DIR\" -I $TMP_COMBINED_FILE" "$SPARK_USER1"

# echo ""
# echo "## Test 6 ##"
# echo "Create a database using the default hive warehouse location with an HDFS and Hive URL policy present"
# echo ""

# echo ""
# echo "Ensure world read and execute on the Hive Warehouse directory, and create a sub-directory for the new database"
# echo ""
# changeHdfsDirPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
# changeHdfsDirPermissions "$HIVE_WAREHOUSE_DIR" 755
# # The notes are creating 'testdb.db' but the ranger policies are providing access for 'gross_test.db'
# # also the db is named 'gross_test'. Let's assume that 'testdb.db' is a typo.
# createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

# ./big-data-tests/spark/6_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST6_FILE"
# runScalaFileInSparkShell "bin/spark-shell -I $TMP_COMBINED_FILE" "$SPARK_USER1"

# echo ""
# echo "## Test 7 ##"
# echo "Create a managed table"
# echo ""

# ./big-data-tests/spark/7_set_policies.sh

# # Create the managed table.
# combineFileWithCommonUtilsFile "$TEST7_AND_8_1_FILE"
# runScalaFileInSparkShell "bin/spark-shell -I $TMP_COMBINED_FILE" "$SPARK_USER1"

# # Select table, describe table and drop table.
# combineFileWithCommonUtilsFile "$TEST7_2_FILE"
# runScalaFileInSparkShell "bin/spark-shell -I $TMP_COMBINED_FILE" "$SPARK_USER1"

# # 'hdfs dfs -ls' and check data after drop.
# listContentsOnHdfsPath "$HIVE_WAREHOUSE_DIR/gross_test.db" "true"

# echo ""
# echo "## Test 8 ##"
# echo "Create a managed table and attempt to access it as a different user"
# echo ""

# ./big-data-tests/spark/8_set_policies.sh

# # Create the managed table.
# combineFileWithCommonUtilsFile "$TEST7_AND_8_1_FILE"
# runScalaFileInSparkShell "bin/spark-shell -I $TMP_COMBINED_FILE" "$SPARK_USER1"

# # c3 - TODO.
# # kdestroy
# # kinit user2

# # Try to access it as another user.
# # combineFileWithCommonUtilsFile "$TEST8_2_FILE"
# # runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.hive_warehouse_dir=\"/$HIVE_WAREHOUSE_DIR\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"

# # Update the HDFS policies
# ./big-data-tests/spark/8_1_set_policies.sh

# # Try to insert into the table as another user.
# # combineFileWithCommonUtilsFile "$TEST8_3_FILE"
# # runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.hive_warehouse_dir=\"/$HIVE_WAREHOUSE_DIR\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"

# echo ""
# echo "## Test 9 ##"
# echo "Attempt to access a managed table as another user when select has been revoked"
# echo ""

# ./big-data-tests/spark/9_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST9_FILE"
# runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"

# echo ""
# echo "## Test 10 ##"
# echo "Attempt various DDL operations against the managed table as a different user"
# echo ""

# ./big-data-tests/spark/10_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST10_FILE"
# runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"

# echo ""
# echo "## Test 11 ##"
# echo "Repeat using an external table"
# echo ""

# ./big-data-tests/spark/11_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST11_1_FILE"
# runScalaFileInSparkShell "bin/spark-shell --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE" "$SPARK_USER1"

# combineFileWithCommonUtilsFile "$TEST11_2_FILE"
# runScalaFileInSparkShell "bin/spark-shell -I $TMP_COMBINED_FILE" "$SPARK_USER2"

# ./big-data-tests/spark/11_1_set_policies.sh

# combineFileWithCommonUtilsFile "$TEST11_3_FILE"
# runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER2\" --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TMP_COMBINED_FILE" "$SPARK_USER2"
