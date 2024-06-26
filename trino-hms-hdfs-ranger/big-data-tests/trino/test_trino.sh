#!/bin/bash

source "./big-data-tests/lib.sh"
source "./big-data-tests/env_variables.sh"

set -e

./big-data-tests/trino/test_1.sh

./big-data-tests/trino/test_2.sh

./big-data-tests/trino/test_3.sh

./big-data-tests/trino/test_4.sh
