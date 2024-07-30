#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "Test4-spark: ############### rename table location without and with Hive URL policies ###############"
echo ""

echo ""
echo "Creating the new URI."

# Create external DB directory 'gross_test2.db'.
createHdfsDir "$HIVE_GROSS_DB_TEST_DIR_SEC"

echo ""
echo "Removing all Hive URL policies."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy ""

waitForPoliciesUpdate

echo ""
echo "User 'spark' doesn't have access to move a table under a new URI. Operation should fail."

# For Hive URL policies to get invoked we need to rename the table URI.
command="spark.sql(\"alter table $GROSS_DB_NAME.$GROSS_TABLE_NAME set location '/$HIVE_GROSS_DB_TEST_DIR_SEC'\")"

op="WRITE"
if [ "$HIVE_VERSION" == "4" ]; then # TODO: investigate this.
  op="READ"
fi
expectedMsg="Permission denied: user [spark] does not have [$op] privilege on [[hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR_SEC, hdfs://namenode/$HIVE_GROSS_DB_TEST_DIR_SEC/"
runSpark "spark" "$command" "shouldFail" "$expectedMsg"

# The location of 'gross_test' is '/data/projects/gross_test/gross_test.db'
#
# The table has been created like this
# spark.sql("create table $GROSS_DB_NAME.$GROSS_TABLE_NAME (id INT, num INT)")
#
# The location of the db was used for the table.
# The table location will be
# '/data/projects/gross_test/gross_test.db/gross_test_table'
#
# Because there was no info specified during the table creation,
#
# spark.sql("describe extended table gross_test.gross_test_table").show
# org.apache.spark.sql.AnalysisException: Table or view not found: table; line 1 pos 18;
# 'DescribeColumn 'gross_test.gross_test_table, true, [info_name#44, info_value#45]
# +- 'UnresolvedTableOrView [table], DESCRIBE TABLE, true
#
# spark.sql("describe table gross_test.gross_test_table").show(true)
# +--------+---------+-------+
# |col_name|data_type|comment|
# +--------+---------+-------+
# |      id|      int|   null|
# |     num|      int|   null|
# +--------+---------+-------+
#
# We can't check the location
#
# verifyCreateWriteFailure "spark" "alterTableData" "$GROSS_DB_NAME" "$GROSS_TABLE_NAME" "hdfs://namenode/data/projects/gross_test/gross_test.db/gross_test_table"

echo ""
echo "Creating Hive URL policies again."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark,trino"
updateHiveDbAllPolicy "*" "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:spark,trino/select:games"
updateHiveUrlPolicy "*" "read,write:spark"

waitForPoliciesUpdate

echo ""
echo "User 'spark' has access to move a table under a new URI. Operation should succeed."

command="spark.sql(\"alter table $GROSS_DB_NAME.$GROSS_TABLE_NAME set location '/$HIVE_GROSS_DB_TEST_DIR_SEC'\")"
runSpark "spark" "$command" "shouldPass"
