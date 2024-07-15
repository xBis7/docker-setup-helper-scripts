#!/bin/bash

source "./big-data-c3-tests/env_variables.sh"
source "./big-data-c3-tests/lib.sh"

set -e

# This script is for running one test at a time.
# We will not be able to run all tests in parallel 
# because each one will wait for the previous one to finish.
# We don't need to set up the policies or the test table every time.

abs_path=$1
test_num=$2
iteration_num=$3
background_run=$4

# 'setup.sh' should have already copied the files.
# Rerun the copy here so that we can apply changes without having to run 'setup.sh' again.
copyTestFilesUnderSpark "$abs_path" "true"

if [ "$test_num" == "1" ]; then
  db_location="/data/projects/gross_load_tests/gross_test.db"

  runCreateDropDbOnRepeatWithAccess "$SPARK_USER1" "$iteration_num" "$db_location" "$background_run"
elif [ "$test_num" == "2" ]; then

  runCreateDropTableOnRepeatWithAccess "$SPARK_USER2" "$iteration_num" "$background_run"
elif [ "$test_num" == "3" ]; then

  runInsertSelectTableOnRepeatWithAccess "$SPARK_USER3" "$iteration_num" "$background_run"
elif [ "$test_num" == "4" ]; then

  runInsertSelectTableOnRepeatNoAccess "$SPARK_USER4" "$iteration_num" "$background_run"
else

  echo "Invalid test number. Try one of the following: 1, 2, 3, 4."
fi
