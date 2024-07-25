#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

updateHdfsPathPolicy "/*" "read,write,execute:hadoop,trino,spark"
updateHiveDbAllPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive,spark,trino"
updateHiveDefaultDbPolicy ""
updateHiveUrlPolicy "*" "select,update,Create,Drop,Alter,Index,Lock,All,Read,Write,ReplAdmin,Refresh:hive"

waitForPoliciesUpdate

echo ""
echo "- INFO: Drop database."
echo "- INFO: User [spark] shouldn't be able to drop non-empty database without 'cascade'."

command="spark.sql(\"drop database if exists $EXTERNAL_DB\")"
# Error message for Spark 3.3.2': 'Cannot drop a non-empty database: $EXTERNAL_DB. Use CASCADE option to drop a non-empty database.'
expectedMsg="Cannot drop a non-empty database: $EXTERNAL_DB. Use CASCADE option to drop a non-empty database."

# Error message for Spark 3.5.0: '[SCHEMA_NOT_EMPTY] Cannot drop a schema'
if [ "$HIVE_VERSION" == "4" ]; then
  expectedMsg="[SCHEMA_NOT_EMPTY] Cannot drop a schema"
fi

runSpark "spark" "$command" "shouldFail" "$expectedMsg"

verifyCreateWriteFailure "spark" "dropDb" "$EXTERNAL_DB"
