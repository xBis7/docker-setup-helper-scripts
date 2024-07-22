#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

abs_path=$1
prepare_env=$2

./big-data-c3-tests/trino-spark-tests/setup.sh "$abs_path" "$prepare_env"

./big-data-c3-tests/trino-spark-tests/spark/test_spark.sh "$abs_path"

# Cleanup any data leftovers from the spark tests.
./big-data-c3-tests/trino-spark-tests/trino/cleanup.sh

./big-data-c3-tests/trino-spark-tests/trino/test_trino.sh "$abs_path"
