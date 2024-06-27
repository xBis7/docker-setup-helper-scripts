#!/bin/bash

source "./load_testing/env_variables.sh"
source "./load_testing/lib.sh"

set -e

# We need 3 spark users with full access and 1 spark user with limited access (only select).

echo ""
echo "Updating HDFS policies."
echo ""
updateHdfsPathPolicy "read,write,execute:$HDFS_USER,$HIVE_USER,$SPARK_USER1,$SPARK_USER2,$SPARK_USER3" "/*"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive all db, cols, tables."
echo ""
updateHiveDbAllPolicy "select,update,create,drop,alter,index,lock:$HIVE_USER,$SPARK_USER1,$SPARK_USER2,$SPARK_USER3/select:$SPARK_USER4"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive default db."
echo ""
updateHiveDefaultDbPolicy "select,update,create,drop,alter,index,lock:$HIVE_USER,$SPARK_USER1,$SPARK_USER2,$SPARK_USER3/select:$SPARK_USER4"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive URL policies."
echo ""
updateHiveUrlPolicy "read,write:$SPARK_USER1,$SPARK_USER2,$SPARK_USER3"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate
