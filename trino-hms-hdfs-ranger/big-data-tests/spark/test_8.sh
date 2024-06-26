#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 8 ##"
echo "Create a managed table and attempt to access it as a different user"
echo ""

# It's the same as in the previous test.
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1" "/$HIVE_WAREHOUSE_DIR/gross_test.db"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# It's the same as in the previous test.
updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

# Run the first command as user1.
command=$(cat <<EOF
  val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")
  df.write.saveAsTable("gross_test.test")
EOF
)

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"

# c3 - TODO.
# kdestroy
# kinit user2

# Run the next commands as user2.

command="spark.sql(\"show databases\").show(false)"

runSpark "$SPARK_USER2" "$command" "shouldPass"

command="spark.sql(\"describe gross_test.test\").show(false)"

runSpark "$SPARK_USER2" "$command" "shouldPass"

command="spark.sql(\"select * from gross_test.test\")"

# In the BigData notes, this is failing with the error below.
# expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":hdfs:"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Update the HDFS policies.
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1/read,execute:$SPARK_USER2" "/$HIVE_WAREHOUSE_DIR/gross_test.db"

waitForPoliciesUpdate

command="spark.sql(\"select * from gross_test.test\")"

runSpark "$SPARK_USER2" "$command" "shouldPass"

command="spark.sql(\"insert into gross_test.test values (4, 'Austin')\")"

# In the BigData notes, this is failing with the error below.
# expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":hdfs:"

expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=WRITE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db/test\":"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"
