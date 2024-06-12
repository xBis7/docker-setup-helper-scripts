#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2
prepare_policies=$3
create_table=$4
test_num=$5
iterations=$6

create_table_file="create_table.scala"

test_file1="user_spark.scala"
test_file2="user_test1.scala"
test_file3="user_test2.scala"
test_file4="user_test3.scala"

run_test_file1=1
run_test_file2=1
run_test_file3=1
run_test_file4=1

# The if block is in case we need to run this script independently.
if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true" "4"
  createHdfsDir "$HIVE_WAREHOUSE_DIR" # This isn't called with retryOperationIfNeeded and it won't print any descriptive output.

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_BASE_POLICIES"

  sleep 15
fi

if [ "$prepare_policies" == "true" ]; then
  ./tests/load_testing/setup_policies.sh
fi

if [ "$create_table" == "true" ]; then
  docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$create_table_file" "$SPARK_MASTER_HOSTNAME:/opt/spark"

  docker exec -it -u spark "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.db_name=\"default\" --conf spark.table_name=\"test2\" -I $create_table_file"
fi

# We will not be able to run them all in parallel from this script 
# because each one will wait for the previous one to finish.
if [[ "$test_num" == "1" ]]; then
  run_test_file1=0
elif [[ "$test_num" == "2" ]]; then
  run_test_file2=0
elif [[ "$test_num" == "3" ]]; then
  run_test_file3=0
elif [[ "$test_num" == "4" ]]; then
  run_test_file4=0
else
  echo ""
  echo "No test file has been selected to run. Exiting..."
  exit 0
fi

if [ "$run_test_file1" == 0 ]; then
  # Copy the test file.
  docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file1" "$SPARK_MASTER_HOSTNAME:/opt/spark"

  location="/opt/hive/data/gross_test/gross_test.db"

  docker exec -it -u spark "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" --conf spark.db_location=\"$location\" -I $test_file1"
fi

if [ "$run_test_file2" == 0 ]; then
  # Copy the test file.
  docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file2" "$SPARK_MASTER_HOSTNAME:/opt/spark"

  docker exec -it -u test1 "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file2"
fi

if [ "$run_test_file3" == 0 ]; then
  # Copy the test file.
  docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file3" "$SPARK_MASTER_HOSTNAME:/opt/spark"

  docker exec -it -u test2 "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file3"
fi

if [ "$run_test_file4" == 0 ]; then
  # Copy the test file.
  docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file4" "$SPARK_MASTER_HOSTNAME:/opt/spark"

  docker exec -it -u test3 "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file4"
fi
