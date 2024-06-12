#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
prepare_env=$2
setup_policies=$3
test_num=$4
iterations=$5

# The if block is in case we need to run this script independently.
if [ "$prepare_env" == "true" ]; then
  ./docker/stop_docker_env.sh "$abs_path"
  ./setup/setup_docker_env.sh "$abs_path"
  ./docker/start_docker_env.sh "$abs_path" "true"
  createHdfsDir "$HIVE_WAREHOUSE_DIR" # This isn't called with retryOperationIfNeeded and it won't print any descriptive output.

  echo ""
  echo "- INFO: Updating Ranger policies. Loading base Hive URL policies. No user will have any access."
  ./setup/load_ranger_policies.sh "$abs_path" "$HIVE_URL_BASE_POLICIES"
fi

if [ "$setup_policies" == "true" ]; then
  ./tests/load_testing/setup_policies.sh
fi

test_file1="user_spark.scala"
test_file2="user_test1.scala"
test_file3="user_test2.scala"
test_file4="user_test3.scala"

# Copy the files.
docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file1" "$SPARK_MASTER_HOSTNAME:/opt/spark"
docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file2" "$SPARK_MASTER_HOSTNAME:/opt/spark"
docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file3" "$SPARK_MASTER_HOSTNAME:/opt/spark"
docker cp "$abs_path/docker-setup-helper-scripts/trino-hms-hdfs-ranger/tests/load_testing/$test_file4" "$SPARK_MASTER_HOSTNAME:/opt/spark"

run_test_file1=1
run_test_file2=1
run_test_file3=1
run_test_file4=1

# We might not be able to run them all in parallel from this script.
if [[ "$test_num" == "1" ]]; then
  run_test_file1=0
elif [[ "$test_num" == "2" ]]; then
  run_test_file2=0
elif [[ "$test_num" == "3" ]]; then
  run_test_file3=0
elif [[ "$test_num" == "4" ]]; then
  run_test_file4=0
else
  run_test_file1=0
  run_test_file2=0
  run_test_file3=0
  run_test_file4=0
fi

if [ "$run_test_file1" == 0 ]; then
  docker exec -it -u spark "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file1"
fi

if [ "$run_test_file2" == 0 ]; then
  docker exec -it -u test1 "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file2"
fi

if [ "$run_test_file3" == 0 ]; then
  docker exec -it -u test2 "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file3"
fi

if [ "$run_test_file4" == 0 ]; then
  docker exec -it -u test3 "$SPARK_MASTER_HOSTNAME" bash -c "bin/spark-shell --conf spark.iteration_num=\"$iterations\" -I $test_file4"
fi
