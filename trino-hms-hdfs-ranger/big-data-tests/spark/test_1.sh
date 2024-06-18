#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 1 ##"
echo "Create a database without having Create permissions"
echo ""

# 1st parameter in all policy methods is 'permissions'.
# 'permissions' have this format -> 'operation1,operation2:user1,user2/operation4,operation5,operation6:user3'
# e.g. 'read,write:hadoop,spark/read,execute:hive'

# 2nd parameter is 'resources'.
# 'resources' have this format -> 'resource1,resource2'
# e.g. '/dir1/*,/dir2/dir3/*'

# 1st parameter: permissions
# 2nd parameter: comma-separated list of paths
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$HIVE_USER,$SPARK_USER1" "/*"

# 1st parameter: permissions
# 2nd parameter: comma-separated list of DBs
updateHiveDbAllPolicy "select:$HIVE_USER,$SPARK_USER1"

# 1st parameter: permissions
updateHiveDefaultDbPolicy "select:$HIVE_USER,$SPARK_USER1"

# 1st parameter: permissions
# 2nd parameter: comma-separated list of URLs
updateHiveUrlPolicy "read:$SPARK_USER1"

waitForPoliciesUpdate

expectedErrorMsg="Permission denied: user [$SPARK_USER1] does not have [CREATE] privilege on [gross_test]"

# 'data/projects' can be replaced by '$EXTERNAL_HIVE_DB_PATH'
command="spark.sql(\"create database gross_test location '/data/projects/gross_test/gross_test.db'\")"

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'true' if the command should succeed and 'false' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'false'
runSpark "$SPARK_USER1" "$command" "false" "$expectedErrorMsg"
