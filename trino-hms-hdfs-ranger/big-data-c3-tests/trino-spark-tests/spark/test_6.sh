#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 6 ##"
echo "Create a database using the default hive warehouse location with an HDFS and Hive URL policy present"
echo ""

echo ""
echo "Ensure world read and execute on the Hive Warehouse directory, and create a sub-directory for the new database"
echo ""

# BigData note: In the notes, this test is explicitly setting the 
# posix permissions for the HiveWarehouse dir to 755.
changeHdfsPathPermissions "$HIVE_WAREHOUSE_ROOT_DIR" 755
changeHdfsPathPermissions "$HIVE_WAREHOUSE_PARENT_DIR" 755
changeHdfsPathPermissions "$HIVE_WAREHOUSE_DIR" 755
# The notes are creating 'testdb.db' but the ranger policies are providing access for 'gross_test.db'
# also the db is named 'gross_test'. Let's assume that 'testdb.db' is a typo.
createHdfsDir "$HIVE_WAREHOUSE_DIR/gross_test.db"

updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write,execute:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"

waitForPoliciesUpdate

command="spark.sql(\"create database gross_test\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"
