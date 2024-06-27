// Create table used for testing.

val db_name = spark.conf.get("spark.db_name", "default")
val table_name = spark.conf.get("spark.table_name", "test_table")

try {
  spark.sql("create table " + db_name + "." + table_name + " (id int, name string)")
} catch {
case e: Exception =>
    println("'create table' failed.")
    println("Message: " + e.getMessage())
    sys.exit(1)
}

println("Test finished without issues.")
sys.exit(0)
