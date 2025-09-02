resource "aws_api_gateway_rest_api" "dev_api_gateway" {
    name = var.api_gateway_name
    description = "API Gateway For DEV Environment"

  endpoint_configuration {
    types = [var.endpoint_type]
  }

  tags = var.tags
}

resource "aws_api_gateway_resource" "date" {
  path_part   = "date"
  parent_id   = aws_api_gateway_rest_api.dev_api_gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.dev_api_gateway.id
}

resource "aws_api_gateway_method" "http_get_method" {
  rest_api_id   = aws_api_gateway_rest_api.dev_api_gateway.id
  resource_id   = aws_api_gateway_resource.date.id
  http_method   = var.http_method
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_api_gateway_integration" {
  rest_api_id             = aws_api_gateway_rest_api.dev_api_gateway.id
  resource_id             = aws_api_gateway_resource.date.id
  http_method             = aws_api_gateway_method.http_get_method.http_method
  integration_http_method = var.integration_http_method
  type                    = "AWS_PROXY"
  uri                     = var.datetime_lambda_invoke_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.dev_api_gateway.id
  depends_on = [
    aws_api_gateway_integration.lambda_api_gateway_integration
  ]
}

resource "aws_api_gateway_stage" "deployment_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.dev_api_gateway.id
  stage_name    = var.stage
}