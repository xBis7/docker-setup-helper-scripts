#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

echo ""
echo "## Test 2 ##"
echo "Create a database without having read,write,execute HDFS permissions"
echo ""

# Policies.
./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:$HDFS_USER,$HIVE_USER" "put"

./ranger_api/create_update/create_update_hive_all_db_policy.sh "alter,create,drop,index,lock,select,update:$HIVE_USER,$SPARK_USER1" "put" "gross_test"

./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select:$HIVE_USER,$SPARK_USER1" "put"

./ranger_api/create_update/create_update_hive_url_policy.sh "read:$SPARK_USER1" "put"

waitForPoliciesUpdate

# Submit test file to Spark shell.
runScalaFileInSparkShell "bin/spark-shell --conf spark.user=\"$SPARK_USER1\" --conf spark.namenode=\"$NAMENODE_NAME\" --conf spark.db_base_dir=\"/$EXTERNAL_HIVE_DB_PATH\" -I $TEST2_FILE" "$SPARK_USER1"
