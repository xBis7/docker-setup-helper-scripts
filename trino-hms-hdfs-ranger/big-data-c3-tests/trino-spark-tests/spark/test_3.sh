#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 3 ##"
echo "Create a database having Create (Hive), read,write,execute (HDFS) and Read and Write (Hive)"
echo ""

updateHdfsPathPolicy "/*" "read,write,execute:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1"

updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"

waitForPoliciesUpdate

# 'data/projects' can be replaced by '$EXTERNAL_HIVE_DB_PATH'
command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"

# Update permissions to the parent dirs.
changeHdfsPathPermissions "$EXTERNAL_HIVE_DB_PATH" 755
changeHdfsPathPermissions "$EXTERNAL_HIVE_DB_PARENT_PATH" 755
