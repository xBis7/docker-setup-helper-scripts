#!/bin/bash

source "./load_testing/env_variables.sh"
source "./load_testing/lib.sh"

set -e

# This script is for running one test at a time.
# We will not be able to run all tests in parallel 
# because each one will wait for the previous one to finish.
# We don't need to set up the policies or the test table every time.

abs_path=$1
test_num=$2
iteration_num=$3

run_test_file1=1
run_test_file2=1
run_test_file3=1
run_test_file4=1

# Check which test to run.
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

# 'setup.sh' should have already copied the files.
# Rerun the copy here so that we can apply changes without having to run 'setup.sh' again.
copyTestFilesUnderSpark "$abs_path"

if [ "$run_test_file1" == 0 ]; then
  db_location="/opt/hive/data/gross_test/gross_test.db"

  runCreateDropDbOnRepeatWithAccess "$SPARK_USER1" "$iteration_num" "$db_location"
fi

if [ "$run_test_file2" == 0 ]; then

  runCreateDropTableOnRepeatWithAccess "$SPARK_USER2" "$iteration_num"
fi

if [ "$run_test_file3" == 0 ]; then

  runInsertSelectTableOnRepeatWithAccess "$SPARK_USER3" "$iteration_num"
fi

if [ "$run_test_file4" == 0 ]; then

  runInsertSelectTableOnRepeatNoAccess "$SPARK_USER4" "$iteration_num"
fi
