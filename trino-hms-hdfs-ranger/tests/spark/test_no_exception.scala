val sqlStr = spark.conf.get("spark.app.sql", "default_sql_value")

try {
  spark.sql(sqlStr)
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
