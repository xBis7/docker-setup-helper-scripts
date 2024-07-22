#!/bin/bash

source "./testlib.sh"

set -e

catalina=$1

docker_hostname=$(getHostnameFromName "ranger_kms")

if [ "$catalina" == "true" ]; then
  docker exec -it "$docker_hostname" cat /var/log/ranger/kms/catalina.out
else
  docker exec -it "$docker_hostname" cat /var/log/ranger/kms/ranger-kms-ranger-kms.example.com-root.log
fi
