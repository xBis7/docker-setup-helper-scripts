#!/bin/bash

source "./testlib.sh"

set -e

name=$1

docker_hostname=$(getHostnameFromName "$name")

docker exec -it "$docker_hostname" bash
