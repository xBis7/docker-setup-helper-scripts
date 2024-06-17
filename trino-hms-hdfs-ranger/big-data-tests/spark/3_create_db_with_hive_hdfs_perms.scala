
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

val dbLocation = dbBaseDir + "/gross_test/gross_test.db"

val result = CommonUtils.createDBNoException(isManaged = false, dbName = dbName, dbLocation = Some(dbLocation))

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
