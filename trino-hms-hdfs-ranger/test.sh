#!/bin/bash

source "./testlib.sh"

abs_path=$1

trino_table="test_table"
hdfs_dir="test"

./start_docker_env.sh "$abs_path"

# Load the default Ranger policies.
./load_ranger_policies.sh "$abs_path" "$DEFAULT_AND_NO_HIVE"
echo "Ranger policies updated."

# Extend to test with HDFS policies??
echo "HDFS user hadoop, should be able to create data with ranger default policies."
if createHdfsTestData "$hdfs_dir"; then
  echo "HDFS test data creation succeeded."
else
  echo "HDFS test data creation failed."
fi
echo ""

# Trino user is postgres.
echo "Trino users need access to both the actual data and the metadata."
echo "Trino user postgres shouldn't be able to create a table without HDFS access."
echo ""

# Failure due to lack of HDFS permissions.
failMsg="Permission denied: user [postgres] does not have [ALL] privilege on [hdfs://namenode:8020/$hdfs_dir]"

retryOperationIfNeeded "createTrinoTable $trino_table $hdfs_dir" "$failMsg" "true"

echo ""
echo "Updating Ranger policies. User [postgres] now will have [ALL] privileges on all HDFS paths."
echo "No user will have permissions on Hive metastore operations on the default db."

./load_ranger_policies.sh "$abs_path" "$POSTGRES_HDFS_ACCESS"

echo ""
echo "Ranger policies updated."

sleep 10

# Failure due to lack of Hive metastore permissions.

failMsg="Permission denied: user [postgres] does not have [CREATE] privilege on"

retryOperationIfNeeded "createTrinoTable $trino_table $hdfs_dir" "$failMsg" "true"

echo ""
echo "Updating Ranger policies. User [postgres] will now have all access to Hive default DB."

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_ALL"

echo ""
echo "Ranger policies updated."

successMsg="CREATE TABLE"

retryOperationIfNeeded "createTrinoTable $trino_table $hdfs_dir" "$successMsg" "false"

echo ""
echo "Updating Ranger policies. User [postgres] will now have only [select] access to Hive default DB."

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT"

echo ""
echo "Select should succeed."

sucessMsg=""

retryOperationIfNeeded "selectDataFromTrinoTable $trino_table" "$successMsg" "false"

echo ""
echo "Alter should fail."

new_table_name="new_$trino_table"

failMsg=""

retryOperationIfNeeded "alterTrinoTable $trino_table $new_table_name" "$failMsg" "true"

echo ""
echo "Updating Ranger policies. User [postgres] will now have [select, alter] access to Hive default DB."

./load_ranger_policies.sh "$abs_path" "$HDFS_AND_HIVE_SELECT_ALTER"

echo ""
echo "Alter should now succeed."

retryOperationIfNeeded "alterTrinoTable $trino_table $new_table_name" "$failMsg" "false"

./stop_docker_env.sh "$abs_path"
