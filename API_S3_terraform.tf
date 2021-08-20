resource "aws_cloudwatch_event_rule" "every_five_minutes" {
  name                = "every-five-minutes"
  description         = "Uploads File Every Five minutes"
  schedule_expression = "rate(5 minutes)"
}



resource "aws_cloudwatch_event_target" "upload_every_five_mins" {
  rule      = "${aws_cloudwatch_event_rule.every_five_minutes.name}"
  target_id = "lambda"
  arn       = "${aws_lambda_function.lambda.arn}"
}



#----------Lambda Permissions-------
resource "aws_lambda_permission" "permissions_for_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.lambda.function_name}"
  principal     = "events.amazonaws.com"
  source_arn    = "${aws_cloudwatch_event_rule.every_one_minute.arn}"
}