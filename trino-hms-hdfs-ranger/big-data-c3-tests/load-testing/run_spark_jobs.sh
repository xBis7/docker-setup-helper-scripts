#!/bin/bash

source "./big-data-c3-tests/env_variables.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1
setup=$2
dataset_size=$3
debug=$4

if [ "$setup" == "true" ]; then
  ./big-data-c3-tests/load-testing/setup.sh "$abs_path"
else
  deleteHdfsDir "test/data"
fi

sales_file="eshop_sales_$dataset_size.csv"
restaurant_file="restaurant_orders_$dataset_size.csv"
stock_file="stock_trades_$dataset_size.csv"

createHdfsDir "test/data"

putFileUnderHdfsPath "$sales_file" "test/data"
putFileUnderHdfsPath "$restaurant_file" "test/data"
putFileUnderHdfsPath "$stock_file" "test/data"

# 'setup.sh' should have already copied the files.
# Rerun the copy here so that we can apply changes without having to run 'setup.sh' again.
copyTestFilesUnderSpark "$abs_path" "true"

echo ""
echo "Starting a Spark job with '$sales_file'."
echo ""

# 1st parameter: user
# 2nd parameter: dataset_type
# 3rd parameter: dataset_size
# 4th parameter: debug
# 5th parameter: background_run
runDatasetSparkJobInSparkShell "$SPARK_USER1" "eshop" "$dataset_size" "$debug" "true" &

echo ""
echo "Starting a Spark job with '$restaurant_file'."
echo ""

runDatasetSparkJobInSparkShell "$SPARK_USER1" "restaurant" "$dataset_size" "$debug" "true" &

echo ""
echo "Starting a Spark job with '$stock_file'."
echo ""

runDatasetSparkJobInSparkShell "$SPARK_USER1" "stock" "$dataset_size" "$debug" "true" &

wait

echo ""
echo "All Spark jobs have finished."
echo ""
