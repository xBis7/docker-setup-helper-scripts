
val dbName = "gross_test"
val tableName = "test"

val result = CommonUtils.createTableWithDfAndNoException(dbName = dbName, tableName = tableName, tablePath = None)

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
