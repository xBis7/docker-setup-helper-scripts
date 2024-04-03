try {
  spark.sql("drop database if exists poc_db")
  println("Test failed. Database dropped successfully.")
  sys.exit(1)
} catch {
  // This is error message for Spark 3.5.0: '[SCHEMA_NOT_EMPTY] Cannot drop a schema'
  // This is error message for Spark 3.3.2: 'Cannot drop a non-empty database: poc_db. Use CASCADE option to drop a non-empty database.'
  case e: Exception if e.getMessage != null && e.getMessage.contains("Cannot drop a non-empty database: poc_db. Use CASCADE option to drop a non-empty database.") =>
    println("Test passed")
    sys.exit(0)
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
