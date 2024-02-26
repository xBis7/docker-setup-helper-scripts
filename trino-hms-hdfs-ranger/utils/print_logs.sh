#!/bin/bash

source "./testlib.sh"

set -e

name=$1

docker_hostname=$(getHostnameFromName "$name")

docker logs "$docker_hostname"
