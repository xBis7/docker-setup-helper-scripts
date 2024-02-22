#!/bin/bash

source "./testlib.sh"

docker_hostname=$(getHostnameFromName "hms")

# This is printing the logs as they are saved from the HMS under the container /tmp dir.
# These logs are different from the HMS service logs from the docker container.
docker exec -it "$docker_hostname" cat /tmp/hive/hive.log
