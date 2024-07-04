
object Utils {

  def createEshopTable(): Any = {
    spark.sql("""
      create table if not exists gross_load_test.eshop_sales (
        sale_id int,
        product_id int,
        customer_id int,
        sale_date string,
        sale_time string,
        product_category string,
        quantity int,
        price float
      )
    """)
  }

  def createRestaurantTable(): Any = {
    spark.sql("""
      create table if not exists gross_load_test.restaurant_orders (
        order_id int,
        restaurant_id int,
        customer_id int,
        order_date string,
        order_time string,
        menu_item string,
        quantity int,
        price float
      )
    """)
  }

  def createStockTable(): Any = {
    spark.sql("""
      create table if not exists gross_load_test.stock_trades (
        trade_id int,
        stock_symbol string,
        trade_date string,
        trade_time string,
        trade_type string,
        quantity int,
        price float
      )
    """)
  }
}

val namenodeName = spark.conf.get("spark.namenode_name", "namenode")
val datasetType = spark.conf.get("spark.dataset_type", "eshop")
val datasetSize = spark.conf.get("spark.dataset_size", "10")
val debug = spark.conf.get("spark.enable.debug.prints", "false").toBoolean

if (datasetType != "eshop" && datasetType != "restaurant" && datasetType != "stock") {
  println(s"Invalid 'spark.dataset_type'. Try one of the following: 'eshop', 'restaurant', 'stock'.")
  sys.exit(1)
}

val ESHOP_SALES_FILENAME = s"eshop_sales_$datasetSize.csv"
val RESTAURANT_ORDERS_FILENAME = s"restaurant_orders_$datasetSize.csv"
val STOCK_TRADES_FILENAME = s"stock_trades_$datasetSize.csv"

val ESHOP_SALES_TABLE_NAME = "eshop_sales"
val RESTAURANT_ORDERS_TABLE_NAME = "restaurant_orders"
val STOCK_TRADES_TABLE_NAME = "stock_trades"

try {
  // Create a managed db if it doesn't exist.
  spark.sql("create database if not exists gross_load_test")
  
  // Create the Hive table if it doesn't exist,
  // to store the data and set the file specific variables.

  var dataFilePath: String = ""
  var tableName: String = ""
  var filterCondition: String = ""
  var sqlQuery: String = ""
  if (datasetType == "eshop") {

    Utils.createEshopTable
    dataFilePath = s"hdfs://$namenodeName:8020/test/data/$ESHOP_SALES_FILENAME"
    tableName = ESHOP_SALES_TABLE_NAME
    filterCondition = "price > 1100"
    sqlQuery = s"""
      SELECT ess.sale_id, ess.product_id, ess.customer_id, ess.sale_date, ess.sale_time, ess.product_category, ess.quantity, ess.price, tess.total_price
      FROM gross_load_test.$tableName ess
      JOIN transformed_$tableName tess ON ess.sale_id = tess.sale_id
    """
  } else if (datasetType == "restaurant") {

    Utils.createRestaurantTable
    dataFilePath = s"hdfs://$namenodeName:8020/test/data/$RESTAURANT_ORDERS_FILENAME"
    tableName = RESTAURANT_ORDERS_TABLE_NAME
    filterCondition = "price > 30"
    sqlQuery = s"""
      SELECT ro.order_id, ro.restaurant_id, ro.customer_id, ro.order_date, ro.order_time, ro.menu_item, ro.quantity, ro.price, tro.total_price
      FROM gross_load_test.$tableName ro
      JOIN transformed_$tableName tro ON ro.order_id = tro.order_id
    """
  } else if (datasetType == "stock") {

    Utils.createStockTable
    dataFilePath = s"hdfs://$namenodeName:8020/test/data/$STOCK_TRADES_FILENAME"
    tableName = STOCK_TRADES_TABLE_NAME
    filterCondition = "price > 600"
    sqlQuery = s"""
      SELECT st.trade_id, st.stock_symbol, st.trade_date, st.trade_time, st.trade_type, st.quantity, st.price, tst.total_price
      FROM gross_load_test.$tableName st
      JOIN transformed_$tableName tst ON st.trade_id = tst.trade_id 
    """
  }

  // Load the data from the HDFS dataset into a DataFrame.
  val df = spark.read
    .option("header", "true")
    .option("inferSchema", "true")
    .csv(dataFilePath)

  if (debug) {
    println("\nPrinting the schema")
    df.printSchema()

    println("\nPrinting the 10 first data from the DataFrame")
    df.show(10)
  }

  // Insert the data from the DataFrame into the Hive table.
  df.write.mode("overwrite").saveAsTable(s"gross_load_test.$tableName")

  // Perform filtering and transformations.
  val filteredDf = df.filter(filterCondition)

  if (debug) {
    println("\nPrinting the 10 first data from the filtered DataFrame")
    filteredDf.show(10)
  }

  val transformedDf = filteredDf.withColumn("total_price", col("quantity") * col("price"))

  if (debug) {
    println("\nPrinting the 10 first data from the transformed DataFrame")
    transformedDf.show(10)
  }

  // Register the DataFrame as a Temporary View.
  transformedDf.createOrReplaceTempView(s"transformed_$tableName")

  // Print the Hive table data
  val hiveTableDf = spark.sql(s"SELECT * FROM gross_load_test.$tableName").show()

  // Run an SQL query. This should use the HMS.
  val resultDf = spark.sql(sqlQuery)

  // Show the query results.
  resultDf.show()

  // Write the query results to HDFS.
  val outputFilePath = s"hdfs://$namenodeName:8020/test/data/output/$tableName"
  resultDf.write
    .mode("overwrite")
    .option("header", "true")
    .csv(outputFilePath)

} catch {
case e: Exception =>
    println("Operation failed.")
    println("Message: " + e.getMessage())
    sys.exit(1)
}

println("Test finished without issues.")
sys.exit(0)
