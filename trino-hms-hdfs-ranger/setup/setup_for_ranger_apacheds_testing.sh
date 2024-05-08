#!/bin/bash

source "./testlib.sh"

set -e

abs_path=$1
op=$2

./docker/stop_docker_containers.sh "$abs_path" "apacheds"
./docker/stop_docker_containers.sh "$abs_path" "ranger"

if [ "$op" == "stop" ]; then
  exit 0
fi

./docker/start_docker_containers.sh "$abs_path" "ranger"
./docker/start_docker_containers.sh "$abs_path" "apacheds"

echo ""
echo "Waiting for the ApacheDS container to start."
sleep 20

echo ""
echo "Search for entry. It will fail and print no such object."
echo "Testing with '| grep NO_SUCH_OBJECT', if the cmd succeeded and grep failed, then the pipeline failed and the script will exit here."
ldapsearch -x -D "uid=admin,ou=system" -w secret -b "cn=test_user,dc=example,dc=com" -H ldap://localhost:10389 "(objectClass=*)" | grep NO_SUCH_OBJECT

echo ""
echo "Importing LDIF file."
ldapadd -x -D "uid=admin,ou=system" -w secret -f $abs_path/$CURRENT_REPO/compose/apacheds/test_files/test_user.ldif -H ldap://localhost:10389

echo ""
echo "Search for entry and print output."
ldapsearch -x -D "uid=admin,ou=system" -w secret -b "cn=test_user,dc=example,dc=com" -H ldap://localhost:10389 "(objectClass=*)"
