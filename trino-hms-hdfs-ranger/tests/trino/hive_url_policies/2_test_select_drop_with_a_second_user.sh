#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "Test2: ############### test select and drop with user 'games' ###############"
echo ""

echo ""
echo "This test can't be performed for trino."
echo "The trino shell user doesn't matter because all operations are performed through hive with user 'postgres'."
echo "We need to find a way to change user 'postgres' or make the shell user the caller."
echo ""