variable "datetime_lambda_invoke_arn" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "api_gateway_name" {
  type = string
}

variable "endpoint_type" {
  type = string
}

variable "http_method" {
  type = string
}

variable "integration_http_method" {
  type = string
}

variable "stage" {
  type =  string
}