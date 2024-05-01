#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1

echo ""
echo "This script "
echo "- deletes all Ranger tarballs under the dist dir"
echo "- deletes all Ranger docker images"
echo "- starts the Ranger docker env"
echo ""
echo "With these steps, we are forcing a full Ranger rebuild so that new changes will persist in the docker env."
echo ""

handleRangerEnv "$abs_path" "stop"

deleteRangerDistTarballs "$abs_path"

deleteRangerDockerImages

handleRangerEnv "$abs_path" "start"
