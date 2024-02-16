#!/bin/bash

source "./testlib.sh"

name=$1

docker_hostname=$(getHostnameFromName "$name")

docker logs "$docker_hostname"
