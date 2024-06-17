
val dbName="gross_test"

val result = CommonUtils.createDBNoException(isManaged = true, dbName = dbName, dbLocation = None)

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
