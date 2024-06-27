// Insert Into table / Select table - 100 iterations, user doesn't have permissions.

val iterations = spark.conf.get("spark.iteration_num", "10").toInt

var counter = 0

// Use table 'test2' which already exists.

while (counter < iterations) {

  // The user has 'select' access but doesn't have 'insert into' access.
  // Therefore, we expect 'select' to succeed and 'insert into' to fail.

  var insertIntoFailed = false

  try {
    spark.sql("insert into default.test2 values (" + counter + ", 'str" + counter + "')")
  } catch {
    case e: Exception =>
      println("Message: " + e.getMessage())
      insertIntoFailed = true
  }

  // If 'insert into' didn't fail as expected, then exit.
  if (!insertIntoFailed) {
    println("'insert into' was expected to fail but it didn't. Exiting...")
    sys.exit(1)
  }

  val errorMsg = " failed during iteration '" + counter + "'"

  try {
    spark.sql("select * from default.test2").show()
  } catch {
    case e: Exception =>
      println("'select table' " + errorMsg)
      println("Message: " + e.getMessage())
      sys.exit(1)
  }

  println("--------------------------")
  println("Finished iteration '" + counter + "'.")
  println("--------------------------")
  printf("\n\n")

  counter += 1
}

println("Test finished without issues.")
sys.exit(0)
