val sqlStr = spark.conf.get("spark.app.sql", "default_sql_value")
val msgStr = spark.conf.get("spark.app.msg", "default_msg_value")

try {
  spark.sql(sqlStr)
  println("Test failed. SQL executed successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains(msgStr) =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(2)
}
