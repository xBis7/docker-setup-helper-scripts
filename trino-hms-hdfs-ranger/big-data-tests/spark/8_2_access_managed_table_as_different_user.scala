
val user = spark.conf.get("spark.user", "spark")
val namenode = spark.conf.get("spark.namenode", "namenode")
val hiveWarehouseDir = spark.conf.get("spark.hive_warehouse_dir", "/user/hive/warehouse")

val dbName = "gross_test"
val tableName = "test"

val showDbResult = CommonUtils.showDatabasesNoException(showResults = false)

if (!showDbResult) {
  sys.exit(1)
}

val describeResult = CommonUtils.describeTableNoException(dbName = dbName, tableName = tableName, showResults = false)

if (!describeResult) {
  sys.exit(1)
}

val expectedError = s"""Permission denied: user=$user, access=EXECUTE, inode="$hiveWarehouseDir/gross_test.db":hdfs:$namenode"""

val selectResult = CommonUtils.selectTableWithException(dbName = dbName, tableName = tableName, showResults = false, expectedErrorMsg = expectedError)

if (selectResult) {
  sys.exit(0)
} else {
  sys.exit(1)
}
