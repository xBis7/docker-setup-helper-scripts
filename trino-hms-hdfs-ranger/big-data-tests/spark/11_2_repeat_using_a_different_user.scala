
val dbName = "gross_test"
val tableName = "test2"

val showDbResult = CommonUtils.showDatabasesNoException(showResults = true)

if (!showDbResult) {
  sys.exit(1)
}

val showTablesResult = CommonUtils.showTablesNoException(dbName = dbName, showResults = true)

if (!showTablesResult) {
  sys.exit(1)
}

val selectResult = CommonUtils.selectTableNoException(dbName = dbName, tableName = tableName, showResults = true)

if (selectResult) {
  sys.exit(0)
} else {
  sys.exit(1)
}
