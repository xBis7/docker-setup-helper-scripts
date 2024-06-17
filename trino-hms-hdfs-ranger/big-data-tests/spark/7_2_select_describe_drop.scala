
val dbName = "gross_test"
val tableName = "test"

val selectResult = CommonUtils.selectTableNoException(dbName = dbName, tableName = tableName, showResults = false)

if (!selectResult) {
  sys.exit(1)
}

val describeResult = CommonUtils.describeTableNoException(dbName = dbName, tableName = tableName, showResults = false)

if (!describeResult) {
  sys.exit(1)
}

val dropResult = CommonUtils.dropTableNoException(dbName = dbName, tableName = tableName)

if (dropResult) {
  sys.exit(0)
} else {
  sys.exit(1)
}
