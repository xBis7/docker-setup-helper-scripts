
val dbBaseDir = spark.conf.get("spark.db_base_dir", "/data/projects")

val dbName="gross_test"

val dbLocation = dbBaseDir + "/gross_test/gross_test.db"

CommonUtils.createDBNoException(isManaged = false, dbName = dbName, dbLocation = Some(dbLocation))
