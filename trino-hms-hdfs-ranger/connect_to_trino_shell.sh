#!/bin/bash

source "./testlib.sh"

docker_hostname=$(getHostnameFromName "trino")

docker exec -it "$docker_hostname" trino
