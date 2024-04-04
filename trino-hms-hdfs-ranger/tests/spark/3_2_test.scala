val sqlStr = spark.conf.get("spark.app.sql", "default_sql_value")
val msgStr = spark.conf.get("spark.app.msg", "default_msg_value")

println(s"Str: $sqlStr")

try {
  spark.sql(sqlStr)
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
