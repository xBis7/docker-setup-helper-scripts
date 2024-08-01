#!/bin/bash

set -e

abs_path=$1

docker image rm --force kerberos-kdc:latest

# docker network create rangernw

docker compose -f "$abs_path"/docker-setup-helper-scripts/compose/kerberos/docker-compose.yml up -d

docker exec -it kerberos-kdc-1 ./keytab_gen.sh

current_user=$(whoami)

sudo chown $current_user:$current_user "$abs_path"/docker-setup-helper-scripts/compose/common/keytabs
sudo chown $current_user:$current_user "$abs_path"/docker-setup-helper-scripts/compose/common/keytabs/*

# docker compose down

# docker network rm rangernw