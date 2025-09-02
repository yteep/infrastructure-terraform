# Module:Storage
bucket_name = "lambda-output-files-sdf"
region = "us-east-1"

# Module:Identity
lambda_s3_policy_name = "LambdaS3BucketManagementPolicy"
lambda_s3_role_name   = "LambdaS3BucketManagementRole"

# Module: Compute
datetime_function_name    = "function_date_time"
archive_file_type         = "zip"
datetime_function_handler = "datetime_function.lambda_handler"
datetime_function_runtime = "python3.13"
lambda_environment        = "dev"
lambda_function_log_level = "info"
apigw_lambda_st_id = "AllowExecutionFromAPIGateway"
apigw_lambda_action = "lambda:InvokeFunction"

# Module: Application Integration
api_gateway_name = "api-gateway-dev"
api_endpoint_type = "REGIONAL"
api_http_method = "GET"
api_integration_http_method = "POST"
api_stage = "dev"