// Create table / Drop table - 100 iterations.

val iterations = spark.conf.get("spark.iteration_num", "10").toInt

var counter = 0

while (counter < iterations) {

  val errorMsg = " failed during iteration '" + counter + "'"

  try {
    spark.sql("create table sports (id int, name string)")
  } catch {
    case e: Exception =>
      println("'create table' " + errorMsg)
      println("Message: " + e.getMessage())
      sys.exit(1)
  }

  try {
    spark.sql("drop table sports")
  } catch {
    case e: Exception =>
      println("'drop table' " + errorMsg)
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
