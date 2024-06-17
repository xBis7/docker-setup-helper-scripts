

val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName = "gross_test"
val tableName = "test2"

val dbLocation = dbBaseDir + "/gross_test/test2"

val createResult = CommonUtils.createTableWithDfAndNoException(dbName = dbName, tableName = tableName, tablePath = Some(dbLocation))

if (!createResult) {
  sys.exit(1)
}

val selectResult = CommonUtils.selectTableNoException(dbName = dbName, tableName = tableName, showResults = true)

if (!selectResult) {
  sys.exit(1)
}

val describeResult = CommonUtils.describeTableNoException(dbName = dbName, tableName = tableName, showResults = false)

if (!describeResult) {
  sys.exit(1)
}
