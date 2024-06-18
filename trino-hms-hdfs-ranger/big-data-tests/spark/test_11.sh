#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 11 ##"
echo "Repeat using an external table"
echo ""

updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1" "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test"

# It's the same as in the previous test.
updateHiveDbAllPolicy "alter,create,drop,index,lock,select,update:$SPARK_USER1/select:$SPARK_USER2" "gross_test"

# It's the same as in the previous test.
updateHiveDefaultDbPolicy "select:$SPARK_USER1,$SPARK_USER2"

# In the BigData notes, this isn't part of the policies 'hdfs://$NAMENODE_NAME/data/projects/gross_test'
updateHiveUrlPolicy "read,write:$SPARK_USER1" "hdfs://$NAMENODE_NAME/$HIVE_WAREHOUSE_DIR/gross_test.db,hdfs://$NAMENODE_NAME/data/projects/gross_test"

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

runSpark "$SPARK_USER1" "$command" "shouldPass"

# TODO: check the command output.
# The 'Type' of the table shoud be 'EXTERNAL' and
# the location should be 'hdfs://$NAMENODE_NAME/data/projects/gross_test/test2'

# Run commands as user2.

# BigData notes: Here there is a Note: 
# "The other user can see the database and tables, but the SELECT fails with: "
# "Permission denied: user=$SPARK_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":hdfs:"
#
# The user has Read permissions on 'gross_test' and therefore all 3 operations should succeed.

# Show databases.
command="spark.sql(\"show databases\").show"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Show tables.
command="spark.sql(\"show tables in gross_test\").show"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Select.
command="spark.sql(\"select * from gross_test.test2\").show"

runSpark "$SPARK_USER2" "$command" "shouldPass"

# Update policies.

updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$SPARK_USER1/read,execute:$SPARK_USER2" "/$HIVE_WAREHOUSE_DIR/gross_test.db,/data/projects/gross_test"

waitForPoliciesUpdate

# BigData notes: we repeat select to show that it fails with the same unexpected EXECUTE error.
# In our case it doesn't fail. So, there is no reason to repeat it.

# Select.
# command="spark.sql(\"select * from gross_test.test2\").show"

# runSpark "$SPARK_USER2" "$command" "shouldPass"

# Insert into.
command="spark.sql(\"insert into gross_test.test2 values (4, 'Austin')\")"

# In the BigData notes, this is failing with the error below.
# expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=EXECUTE, inode=\"/$HIVE_WAREHOUSE_DIR/gross_test.db\":hdfs:"

expectedErrorMsg="Permission denied: user=$SPARK_USER2, access=WRITE, inode=\"/data/projects/gross_test/test2\":spark:"

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

