#!/bin/bash

source "./big-data-c3-tests/env_variables.sh"
source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1
setup=$2

if [ "$setup" == "true" ]; then
  ./big-data-c3-tests/load-testing/setup.sh "$abs_path"

  createHdfsDir "/test/data"
fi

