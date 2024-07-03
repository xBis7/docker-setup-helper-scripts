#!/bin/bash

source "./big-data-c3-tests/lib.sh"

set -e

abs_path=$1
load_testing=$2

copyTestFilesUnderSpark "$abs_path" "$load_testing"
