#!/bin/bash

source "./testlib.sh"

set -e

docker_hostname=$(getHostnameFromName "ranger_usersync")

# This is printing the logs as they are saved from ranger-usersync under the container.
# The ranger-usersync container is printing the output from the setup but not the service itself.
docker exec -it "$docker_hostname" cat /var/log/ranger/usersync/usersync-ranger-usersync.example.com-.log
