try {
  spark.sql("alter table animals add partition (name='cow')")
  println("Test passed")
  sys.exit(0)
} catch {
  case e: Exception =>
    println("Test failed. Message: " + e.getMessage())
    sys.exit(1)
}
