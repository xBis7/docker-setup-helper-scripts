try {
  spark.sql("insert into sports values(1, 'football')")
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
