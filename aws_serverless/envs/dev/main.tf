module "storage" {
  source = "../../modules/storage"

  # Variables
  bucket_name = var.bucket_name
  region = var.region
  tags = var.common_tags
}

module "identity" {
  source = "../../modules/identity"

  # Variables
  policy_lambda_s3_bucket_manage = var.lambda_s3_policy_name
  role_lambda_s3_bucket_access   = var.lambda_s3_role_name
  tags = var.common_tags
}

module "compute" {
  source = "../../modules/compute"

  #Variables
  datetime_function = var.datetime_function_name
  archive_file_type = var.archive_file_type
  handler           = var.datetime_function_handler
  runtime           = var.datetime_function_runtime
  env               = var.lambda_environment
  log_level         = var.lambda_function_log_level
  tags              = var.common_tags
  lambda_iam_role   = module.identity.lambda_role
  api_gateway_id = module.app-integration.id_api_gateway
  apigw_lambda_st_id = var.apigw_lambda_st_id
  apigw_lambda_action = var.apigw_lambda_action
}

module "app-integration" {
  source = "../../modules/app-integration"

  # Variables  
  datetime_lambda_invoke_arn = module.compute.lambda_invoke_arn
  tags = var.common_tags
  api_gateway_name = var.api_gateway_name
  endpoint_type = var.api_endpoint_type
  http_method = var.api_http_method
  integration_http_method = var.api_integration_http_method
  stage = var.api_stage
}