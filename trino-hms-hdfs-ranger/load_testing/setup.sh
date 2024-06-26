#!/bin/bash

source "./load_testing/env_variables.sh"
source "./load_testing/lib.sh"

set -e

abs_path=$1

if [ "$CURRENT_ENV" == "local" ]; then
  ./load_testing/setup_local_env.sh "$abs_path"
fi

./load_testing/setup_policies.sh

# Copy all files under spark.
copyTestFilesUnderSpark "$abs_path"

createSparkTableForTestingDdlOps "$SPARK_USER1"
