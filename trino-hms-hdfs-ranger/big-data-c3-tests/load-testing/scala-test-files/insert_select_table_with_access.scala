// Insert Into table / Select table - 100 iterations.

val iterations = spark.conf.get("spark.iteration_num", "10").toInt

var counter = 0

// Create a table.
try {
  spark.sql("create table test (id int, name string)")
} catch {
  case e: Exception =>
    println("'create table' failed.")

    val error = e.getMessage()

    println("Message: " + error)

    // If it already exists, drop it and retry once.
    if (error.contains("already exists")) {
      // Drop.
      try {
        spark.sql("drop table test")
      } catch {
        case e: Exception =>
          println("'drop table' failed.")
          println("Message: " + e.getMessage())
          sys.exit(1)
      }

      // Retry the create.
      try {
        spark.sql("create table test (id int, name string)")
      } catch {
      case e: Exception =>
        println("'create table' failed.")
        println("Message: " + e.getMessage())
        sys.exit(1)
      }

    } else {
      // It's an unexpected error. Exit.
      sys.exit(1)
    }
}

while (counter < iterations) {

  val errorMsg = " failed during iteration '" + counter + "'"

  try {
    spark.sql("insert into default.test values (" + counter + ", 'str" + counter + "')")
  } catch {
    case e: Exception =>
      println("'insert into' " + errorMsg)
      println("Message: " + e.getMessage())
      sys.exit(1)
  }

  try {
    spark.sql("select * from default.test").show()
  } catch {
    case e: Exception =>
      println("'select' " + errorMsg)
      println("Message: " + e.getMessage())
      sys.exit(1)
  }

  println("--------------------------")
  println("Finished iteration '" + counter + "'.")
  println("--------------------------")

  counter += 1
}

println("Test finished without issues.")
sys.exit(0)
