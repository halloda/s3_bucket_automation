
#-----create lambda funtion that runs zipped API_s3.py
resource "aws_lambda_function" "upload_file" {
  filename="s3_bucket_upload.zip"
  function_name="uploadFile"
  role="aws_iam_role.iam_for_lambda" #placeholder 
  handler="index.handler"
}

#-----create the cloudwatch event rule that schedules the lambda function every 5 minutes
resource "aws_cloudwatch_event_rule" "every_five_minutes" {
  name                = "every-five-minutes"
  description         = "Uploads File Every Five minutes"
  schedule_expression = "rate(5 minutes)"
}


#-----create the cloudwatch event target 
resource "aws_cloudwatch_event_target" "upload_every_five_mins" {
  rule      = aws_cloudwatch_event_rule.every_five_minutes.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda.arn
}



#----------Lambda Permissions-------
resource "aws_lambda_permission" "permissions_for_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.upload_file
  principal     = "events.amazonaws.com"
  source_arn    = "arn:aws:events:sample_arn" #placeholder
}
