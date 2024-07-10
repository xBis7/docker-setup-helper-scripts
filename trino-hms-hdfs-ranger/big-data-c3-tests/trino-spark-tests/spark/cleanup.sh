#!/bin/bash

source "./big-data-c3-tests/lib.sh"
source "./big-data-c3-tests/env_variables.sh"

set -e

echo ""
echo "Cleanup"
echo ""

command="spark.sql(\"drop table if exists gross_test.test2\")"

runSpark "$SPARK_USER1" "$command" "shouldPass"

deleteHdfsDir "data/projects/gross_test/test2"

echo ""
echo "./utils/connect_to_spark_shell.sh"
echo "Seq((1, \"John\"), (2, \"Jane\"), (3, \"Bob\")).toDF(\"id\", \"name\").write.option(\"path\", \"/data/projects/gross_test/test2\").saveAsTable(\"gross_test.test2\")"
echo "spark.sql(\"show tables in gross_test\").show"
echo "spark.sql(\"select * from gross_test.test2\").show"
echo ""

