#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

./big-data-c3-tests/trino-spark-tests/kms/test_key.sh

./big-data-c3-tests/trino-spark-tests/kms/test_encryption.sh

