output "lambda_invoke_arn" {
  value = aws_lambda_function.datetime_lambda_function.invoke_arn
}