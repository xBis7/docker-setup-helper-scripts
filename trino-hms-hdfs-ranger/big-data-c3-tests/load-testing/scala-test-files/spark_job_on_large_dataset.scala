// Create table used for testing.

val file_name = spark.conf.get("spark.file_name", "electronic_shop_sales_10.csv")

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
