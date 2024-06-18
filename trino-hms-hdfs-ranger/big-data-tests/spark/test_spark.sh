#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

abs_path=$1

./big-data-tests/copy_files_under_spark.sh "$abs_path"

# c3 - TODO.
# kinit

./big-data-tests/spark/test_1.sh

./big-data-tests/spark/test_2.sh

./big-data-tests/spark/test_3.sh

./big-data-tests/spark/test_4.sh

./big-data-tests/spark/test_5.sh

./big-data-tests/spark/test_6.sh

./big-data-tests/spark/test_7.sh

./big-data-tests/spark/test_8.sh

./big-data-tests/spark/test_9.sh

./big-data-tests/spark/test_10.sh

./big-data-tests/spark/test_11.sh
