#!/bin/bash

source "./big-data-tests/lib.sh"

set -e

abs_path=$1

copyTestFilesUnderSpark "$abs_path"
