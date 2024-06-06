#!/bin/bash

set -e

# Generates 'jetty-runner-shaded-1.0-SNAPSHOT-shaded.jar' based on the pom file.
mvn clean package

# Installs 'jetty-runner-shaded-1.0-SNAPSHOT-shaded.jar' and renames it based on the provided info.
# The new name will be 'jetty-runner-9.4.51.v20230217-shaded.jar'.
mvn install:install-file -Dfile=target/jetty-runner-shaded-1.0-SNAPSHOT-shaded.jar -DgroupId=org.eclipse.jetty -DartifactId=jetty-runner -Dversion=9.4.51.v20230217 -Dclassifier=shaded -Dpackaging=jar
