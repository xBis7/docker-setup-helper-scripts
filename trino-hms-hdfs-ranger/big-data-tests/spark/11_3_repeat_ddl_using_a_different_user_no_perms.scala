

val user = spark.conf.get("spark.user", "spark")
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName = "gross_test"
val tableName = "test2"
val newTableName = "test3"

val expectedError = s"""Permission denied: user=$user, access=WRITE, inode="$dbBaseDir/gross_test":hdfs"""

val insertResult = CommonUtils.insertIntoTableWithException(dbName = dbName, tableName = tableName, expectedErrorMsg = expectedError)

if (!insertResult) {
  sys.exit(1)
}

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


