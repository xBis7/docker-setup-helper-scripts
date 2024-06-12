#!/bin/bash

source "./testlib.sh"

set -e

echo ""
echo "Updating HDFS policies."
echo ""
./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:hadoop,spark,postgres,test1,test2" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive all db, cols, tables."
echo ""
./ranger_api/create_update/create_update_hive_all_db_policy.sh "select,update,create,drop,alter,index,lock:spark,postgres,test1,test2/select:games,test3" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive default db."
echo ""
./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select,update,create,drop,alter,index,lock:spark,postgres,test1,test2/select:games,test3" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive URL policies."
echo ""
./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:spark,test1,test2" "put"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate
