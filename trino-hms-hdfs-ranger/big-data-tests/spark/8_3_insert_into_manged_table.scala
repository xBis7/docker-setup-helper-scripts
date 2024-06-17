
val user = spark.conf.get("spark.user", "spark")
val namenode = spark.conf.get("spark.namenode", "namenode")
val hiveWarehouseDir = spark.conf.get("spark.hive_warehouse_dir", "/user/hive/warehouse")

val dbName = "gross_test"
val tableName = "test"

val expectedError = s"""Permission denied: user=$user, access=EXECUTE, inode="$hiveWarehouseDir/gross_test.db":hdfs:$namenode"""

val result = CommonUtils.insertIntoTableWithException(dbName = dbName, tableName = tableName, expectedErrorMsg = expectedError)

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
