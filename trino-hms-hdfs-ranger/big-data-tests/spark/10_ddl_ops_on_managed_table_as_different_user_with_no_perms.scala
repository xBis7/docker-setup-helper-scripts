
val user = spark.conf.get("spark.user", "spark")

val dbName = "gross_test"
val tableName = "test"
val newTableName = "test2"

val dropExpectedError = s"Permission denied: user [$user] does not have [DROP] privilege on [$dbName/$tableName]"

val dropResult = CommonUtils.dropTableWithException(dbName = dbName, tableName = tableName, expectedErrorMsg = dropExpectedError)

if (!dropResult) {
  sys.exit(1)
}

val alterExpectedError = s"Permission denied: user [$user] does not have [ALTER] privilege on [$dbName/$tableName]"

val alterResult = CommonUtils.alterTableWithException(dbName = dbName, oldTableName = tableName, newTableName = newTableName, expectedErrorMsg = alterExpectedError)

if (!alterResult) {
  sys.exit(1)
}

val createExpectedError = s"Permission denied: user [$user] does not have [CREATE] privilege on [$dbName/$newTableName]"

val createResult = CommonUtils.createTableWithException(dbName = dbName, tableName = newTableName, expectedErrorMsg = createExpectedError)

if (createResult) {
  sys.exit(0)
} else {
  sys.exit(1)
}


