variable "datetime_function" {
  type = string
}

variable "archive_file_type" {
  type = string
}

variable "handler" {
  type = string
}

variable "runtime" {
  type = string
}

variable "env" {
  type = string
}

variable "log_level" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "lambda_iam_role" {
  type = string
}

variable "api_gateway_id" {
  type = string
}

variable "apigw_lambda_st_id" {
  type = string
}

variable "apigw_lambda_action" {
  type = string
}
