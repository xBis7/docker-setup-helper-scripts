try {
  val rowsNum = spark.sql("select * from default.spark_test_table").count()
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
