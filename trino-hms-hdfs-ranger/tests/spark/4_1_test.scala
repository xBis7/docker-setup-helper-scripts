val sqlStr = spark.conf.get("spark.app.sql", "default_sql_value")

try {
  val rowsNum = spark.sql(sqlStr).count()
  if (rowsNum != 4) {
    println("Test failed. Expected: 4 rows. Actual: " + rowsNum + " rows")
    sys.exit(1)
  }

  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
