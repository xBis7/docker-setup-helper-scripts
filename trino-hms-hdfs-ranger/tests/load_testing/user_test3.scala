// Insert Into table / Select table - 100 iterations, user doesn't have permissions.

val iterations = spark.conf.get("spark.iteration_num", "10").toInt

var counter = 0

// Use table 'test' which already exists.

while (counter < iterations) {

  try {
    spark.sql("insert into default.test values (" + counter + ", 'str" + counter + "')")
  } catch {
    case e: Exception =>
      println("Message: " + e.getMessage())
  }

  try {
    spark.sql("select * from default.test").show()
  } catch {
    case e: Exception =>
      println("Message: " + e.getMessage())
  }

  println("--------------------------")
  println("Finished iteration '" + counter + "'.")
  println("--------------------------")
  printf("\n\n")

  counter += 1
}

println("Test finished without issues.")
sys.exit(0)
