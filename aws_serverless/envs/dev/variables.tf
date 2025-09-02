# Module:Storage
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "lambda-output-files-00001"
}

variable "region" {
  type = string
}

#Module:Identity
variable "lambda_s3_policy_name" {
  description = "Lambda-S3-Bucket management policy name"
  type        = string
  default     = "lambda_s3_bucket_management_policy"
}

variable "lambda_s3_role_name" {
  description = "Lambda-S3-Bucket management role name"
  type        = string
  default     = "lambda_s3_bucket_management_role"
}

# Module: Compute
variable "datetime_function_name" {
  description = "Lambda function name"
  type        = string
  default     = "datetime_function"
}

variable "archive_file_type" {
  description = "package file type"
  type        = string
  default     = "zip"
}

variable "datetime_function_handler" {
  description = "lambda handler"
  type        = string
  default     = "index.handler"
}

variable "datetime_function_runtime" {
  description = "lambda runtime"
  type        = string
  default     = "python3.12"
}

variable "lambda_environment" {
  description = "Env in Lambda"
  type        = string
  default     = "test"
}

variable "lambda_function_log_level" {
  description = "Log level"
  type        = string
  default     = "debug"
}

variable "apigw_lambda_st_id" {
  type = string
  default = "AllowExecutionFromAPIGateway"
}

variable "apigw_lambda_action" {
  type = string
  default = "lambda:InvokeFunction"
}


# Common tags
variable "common_tags" {
  type = map(string)
  default = {
    Owner       = "backend-team"
    Environment = "dev"
    Project     = "serverless-project"
  }
}

# Module: Application Integration
variable "api_gateway_name" {
  type = string
  default = "API-services-dev"
}

variable "api_endpoint_type" {
  type = string
  default = "PRIVATE"
}

variable "api_http_method" {
  type = string
  default = "POST"
}

variable "api_integration_http_method" {
  type = string
  default = "POST"
}

variable "api_stage" {
  type =  string
  default = "dev"
}