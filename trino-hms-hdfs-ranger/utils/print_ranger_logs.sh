#!/bin/bash

source "./testlib.sh"

set -e

docker_hostname=$(getHostnameFromName "ranger")

# This is printing the logs as they are saved from ranger under the container.
# The ranger container is printing the output from the setup but not the service itself.

# Under the container there are these log files
# ranger@ranger:/$ ls -lah /var/log/ranger
# total 1.1M
# drwxr-xr-x 1 ranger ranger 4.0K May  1 13:46 .
# drwxr-xr-x 1 root   root   4.0K May  1 13:45 ..
# -rw-r--r-- 1 ranger ranger 1.9K May  1 13:47 access-localhost-2024-05-01.log
# -rw-r--r-- 1 ranger ranger  11K May  1 13:47 catalina.out
# -rw-r--r-- 1 ranger ranger 116K May  1 13:47 ranger-admin-ranger.example.com-.log
# -rw-r--r-- 1 ranger ranger 921K May  1 13:46 ranger-admin-ranger.example.com-ranger.log
# -rw-r--r-- 1 ranger ranger    0 May  1 13:46 ranger_admin_perf.log
# -rw-r--r-- 1 ranger ranger    0 May  1 13:46 ranger_admin_sql.log
# -rw-r--r-- 1 ranger ranger 2.2K May  1 13:46 ranger_db_patch.log

# The EmbeddedServer prints its logs in the catalina.out file.
docker exec -it "$docker_hostname" cat /var/log/ranger/catalina.out

