#!/bin/bash

source "./testlib.sh"

set -e

# We need 3 spark users with full access and 1 spark user with limited access (only select).

hdfs_user=${1:-"hadoop"}
hive_user=${2:-"postgres"}
spark_user_all=${3:-"spark"}
spark_user2_all=${4:-"test1"}
spark_user3_all=${5:-"test2"}
spark_user_limited=${6:-"test3"}

echo ""
echo "Updating HDFS policies."
echo ""
./ranger_api/create_update/create_update_hdfs_path_policy.sh "/*" "read,write,execute:$hdfs_user,$hive_user,$spark_user_all,$spark_user2_all,$spark_user3_all" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive all db, cols, tables."
echo ""
./ranger_api/create_update/create_update_hive_all_db_policy.sh "select,update,create,drop,alter,index,lock:$hive_user,$spark_user_all,$spark_user2_all,$spark_user3_all/select:$spark_user_limited" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive default db."
echo ""
./ranger_api/create_update/create_update_hive_defaultdb_policy.sh "select,update,create,drop,alter,index,lock:$hive_user,$spark_user_all,$spark_user2_all,$spark_user3_all/select:$spark_user_limited" "put"

echo ""
echo "---------------------------------------------------"

echo ""
echo "Updating Hive URL policies."
echo ""
./ranger_api/create_update/create_update_hive_url_policy.sh "read,write:$spark_user_all,$spark_user2_all,$spark_user3_all" "put"

echo ""
echo "---------------------------------------------------"

waitForPoliciesUpdate
