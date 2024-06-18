
val command = spark.conf.get("spark.encoded.command", "default.spark.sql")
val expectedErrorMsg = spark.conf.get("spark.encoded.expected_error", "Permission denied")

val result = CommonUtils.runCommandWithException(encodedCommandStr = command, encodedExpectedErrorMsg = expectedErrorMsg)

if (result) {
  sys.exit(0)
} else {
  sys.exit(1)
}
