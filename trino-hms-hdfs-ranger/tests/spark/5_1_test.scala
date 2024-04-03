try {
  spark.sql("alter table default.spark_test_table rename to default.new_spark_test_table")
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
