try {
  spark.sql("drop database if exists poc_db cascade")
  println("Test failed. Database dropped successfully.")
  sys.exit(1)
} catch {
  case e: Exception if e.getMessage != null && e.getMessage.contains("Permission denied: user [spark] does not have [DROP] privilege on [poc_db]") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
