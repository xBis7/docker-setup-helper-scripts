#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 3 ##"
echo "Create a database having Create (Hive), read,write,execute (HDFS) and Read and Write (Hive)"
echo ""

updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$HIVE_USER,$SPARK_USER1" "/*"

# It's the same as in the previous test and it can be skipped.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$HIVE_USER,$SPARK_USER1" "gross_test"

# It's the same as in the previous test and it can be skipped.
updateHiveDefaultDbPolicy "select:$HIVE_USER,$SPARK_USER1"

updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/$HIVE_GROSS_TEST_DIR"

waitForPoliciesUpdate

# 'data/projects' can be replaced by '$EXTERNAL_HIVE_DB_PATH'
command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'true' if the command should succeed and 'false' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'false'
runSpark "$SPARK_USER1" "$command" "true"
