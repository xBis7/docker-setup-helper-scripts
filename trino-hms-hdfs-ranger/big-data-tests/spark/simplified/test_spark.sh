#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

abs_path=$1

# Copy the files under Spark.
copySimplifiedTestFilesUnderSpark "$abs_path"

# Run the tests.
./big-data-tests/spark/simplified/test_1/test.sh

./big-data-tests/spark/simplified/test_2/test.sh