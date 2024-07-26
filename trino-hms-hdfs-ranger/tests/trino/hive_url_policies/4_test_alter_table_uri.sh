#!/bin/bash

source "./testlib.sh"
source "./big-data-c3-tests/lib.sh"

set -e

echo ""
echo "Test4-trino: ############### rename table location without and with Hive URL policies ###############"
echo ""

echo ""
echo "This test can't be performed for trino."
echo "The command 'alter table' in trino doesn't allow the user to change the table location."
echo "There is no direct way to alter the table URI in trino."
echo "A possible approach would be to create a new table, copy the data and drop the old table."
echo "That approach wouldn't invoke Hive URL policies for an 'alter' command."
echo ""