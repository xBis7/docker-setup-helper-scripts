
val command = spark.conf.get("spark.encoded.command", "default.spark.sql")

val result = CommonUtils.runCommandNoException(encodedCommandStr = command)

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
