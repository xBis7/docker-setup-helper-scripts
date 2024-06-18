#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 3 ##"
echo "Create a database having Create (Hive), read,write,execute (HDFS) and Read and Write (Hive)"
echo ""

updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1" "/*"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1"

updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/data/projects/gross_test"

waitForPoliciesUpdate

# 'data/projects' can be replaced by '$EXTERNAL_HIVE_DB_PATH'
command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"
