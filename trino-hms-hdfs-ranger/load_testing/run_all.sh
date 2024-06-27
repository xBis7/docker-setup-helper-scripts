#!/bin/bash

source "./load_testing/env_variables.sh"
source "./load_testing/lib.sh"

set -e

abs_path=$1
setup=$2
iteration_num=$3

if [ "$setup" == "true" ]; then
  ./load_testing/setup.sh "$abs_path"
fi

echo ""
echo "---Starting test 1.---"
echo ""

./load_testing/run_test.sh "$abs_path" 1 "$iteration_num" "true" &

echo ""
echo "Test 1 started."
echo ""
echo "---Starting test 2.---"
echo ""

./load_testing/run_test.sh "$abs_path" 2 "$iteration_num" "true" &

echo ""
echo "Test 2 started."
echo ""
echo "---Starting test 3.---"
echo ""

./load_testing/run_test.sh "$abs_path" 3 "$iteration_num" "true" &

echo ""
echo "Test 3 started."
echo ""
echo "---Starting test 4.---"
echo ""

./load_testing/run_test.sh "$abs_path" 4 "$iteration_num" "true" &

echo ""
echo "Test 4 started."
echo ""

wait

echo ""
echo "All tests have finished."
echo ""
