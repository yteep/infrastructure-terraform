# Package the Lambda function code
data "archive_file" "file_datetime_lambda_function" {
  type        = var.archive_file_type
  source_file = "${path.module}/lambda/datetime_function.py"
  output_path = "${path.module}/lambda/function.zip"
}

# Lambda function
resource "aws_lambda_function" "datetime_lambda_function" {
  filename         = data.archive_file.file_datetime_lambda_function.output_path
  description = "Return Current Date & Time"
  function_name    = var.datetime_function
  role             = var.lambda_iam_role
  handler          = var.handler
  source_code_hash = data.archive_file.file_datetime_lambda_function.output_base64sha256

  runtime = var.runtime

  environment {
    variables = {
      ENVIRONMENT = var.env
      LOG_LEVEL   = var.log_level
    }
  }

  tags = var.tags
}

# Functional URL
resource "aws_lambda_function_url" "url_datetime_lambda_function" {
  function_name      = aws_lambda_function.datetime_lambda_function.function_name
  authorization_type = "NONE"
  invoke_mode        = "BUFFERED"
}

# Lambda Resource-based policy statements 
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = var.apigw_lambda_st_id
  action        = var.apigw_lambda_action
  function_name = aws_lambda_function.datetime_lambda_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn = "arn:aws:execute-api:us-east-1:ACCOUNT_ID:${var.api_gateway_id}/*/*/*"
}