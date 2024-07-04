#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "## Test 11 ##"
echo "Repeat using an external table"
echo ""

updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test" "read,write,execute:$SPARK_USER1"

# It's the same as in the previous test.
updateHiveDbAllPolicy "gross_test" "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# There is no note about Hive URL policies but as long as we update HDFS policies and add '/data/projects/gross_test'
# and we are expecting the command to succeed, then we also need to add 'hdfs://$NAMENODE_NAME/data/projects/gross_test' here.

# If we replace 'updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"'
# with          'updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db" "read,write:$SPARK_USER1"'
# Then during the table creation, we will get this error
# 'org.apache.hadoop.hive.ql.metadata.HiveException: MetaException(message:Permission denied: user [$SPARK_USER1] does not have [WRITE] privilege on [[hdfs://$NAMENODE_NAME/data/projects/gross_test/test2, hdfs://$NAMENODE_NAME/data/projects/gross_test/test2/]])'
# but the table creation will actually succeed and the data will be there.
updateHiveUrlPolicy "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test" "read,write:$SPARK_USER1"

waitForPoliciesUpdate

# Run commands as user1.

# Create.
command=$(cat <<EOF
  val df = Seq((1, "John"), (2, "Jane"), (3, "Bob")).toDF("id", "name")
  df.write.option("path", "/data/projects/gross_test/test2").saveAsTable("gross_test.test2")
EOF
)

# 1st parameter: the user to execute the command
# 2nd parameter: the command to be executed
# 3rd parameter: 'shouldPass' if the command should succeed and 'shouldFail' if the command should fail
# 4th parameter: the expected error message if the previous parameter is 'shouldFail'
runSpark "$SPARK_USER1" "$command" "shouldPass"

# Select.
command="spark.sql(\"select * from gross_test.test2\").show"

runSpark "$SPARK_USER1" "$command" "shouldPass"

# Describe table.
command="spark.sql(\"describe extended gross_test.test2\").show(false)"

# The 'Type' of the table shoud be 'EXTERNAL' and
# the location should be 'hdfs://$NAMENODE_NAME/data/projects/gross_test/test2'
# Run the command twice, so that we can check each time for a different part of the output.
expectedOutput="|Type                        |EXTERNAL"
runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"

expectedOutput="|Location                    |hdfs://$NAMENODE_NAME/data/projects/gross_test/test2"
runSpark "$SPARK_USER1" "$command" "shouldPass" "$expectedOutput"

# Change directory permissions so that another user won't be able to execute on HDFS paths without a Ranger policy. 
changeHdfsDirPermissions "data/projects/gross_test" 750

# Run commands as user2.

# Show databases.
command="spark.sql(\"show databases\").show"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Show tables.
command="spark.sql(\"show tables in gross_test\").show"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Select.
command="spark.sql(\"select * from gross_test.test2\").show"
expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=EXECUTE, inode=\"/data/projects/gross_test\":"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

# Update policies.

updateHdfsPathPolicy "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test" "read,write,execute:$SPARK_USER1/read,execute:$SPARK_USER2"
waitForPoliciesUpdate

# Select. Now it should succeed.
command="spark.sql(\"select * from gross_test.test2\").show"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Insert into.
command="spark.sql(\"insert into gross_test.test2 values (4, 'Austin')\")"
expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=EXECUTE, inode=\"/data/projects/gross_test\":"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

# Drop.
command="spark.sql(\"drop table gross_test.test2\")"

expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [DROP] privilege on [gross_test/test2]"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

# Alter.
command="spark.sql(\"alter table gross_test.test2 rename to gross_test.test3\")"

expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [ALTER] privilege on [gross_test/test2]"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

# Create.
command="spark.sql(\"create table gross_test.test3 (id int, greeting string)\")"

expectedErrorMsg="Permission denied: user [$SPARK_USER2] does not have [CREATE] privilege on [gross_test/test3]"

runSpark "$SPARK_USER2" "$command" "shouldFail" "$expectedErrorMsg"

