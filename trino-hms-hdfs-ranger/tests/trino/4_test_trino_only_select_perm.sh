#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "- INFO: Updating Ranger policies. User [trino] will now have only [select] access to Hive default DB."
echo "- INFO: HDFS access for user [trino] has been removed."

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"
updateHiveDefaultDbPolicy "select:spark,trino"
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Select from $TRINO_TABLE table."
echo "- INFO: [select] should succeed."

command="select * from hive.$DEFAULT_DB.$TRINO_TABLE"
expectedMsg="dog"
runTrino "trino" "$command" "shouldPass" "$expectedMsg"

echo ""
echo "- INFO: Insert into $TRINO_TABLE table."
echo "- INFO: [alter] should fail."
command="insert into hive.default.$TRINO_TABLE values ('5', 'cat');"
expectedMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

# id is a varchar. We need to use ''
verifyCreateWriteFailure "trino" "insertInto" "$DEFAULT_DB" "$TRINO_TABLE" "'5'"

echo ""
echo "- INFO: Rename $TRINO_TABLE table."
echo "- INFO: [alter] should fail."

command="alter table hive.$DEFAULT_DB.$TRINO_TABLE rename to $NEW_TRINO_TABLE_NAME"
expectedMsg="Permission denied: user [trino] does not have [ALTER] privilege"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "trino" "renameTable" "$DEFAULT_DB" "$TRINO_TABLE"

echo ""
echo "- INFO: Insert into $TABLE_ANIMALS table."
echo "- INFO: [alter] should fail."
command="insert into hive.default.$TABLE_ANIMALS values (1, 'cat');"
expectedMsg="Permission denied: user=trino, access=WRITE, inode=\"/\":hadoop:supergroup:drwxr-xr-x"
runTrino "trino" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "trino" "insertInto" "$DEFAULT_DB" "$TABLE_ANIMALS" "1"
