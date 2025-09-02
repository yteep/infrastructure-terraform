output "id_api_gateway" {
  value = aws_api_gateway_rest_api.dev_api_gateway.id
}

output "endpoint_url" {
  value = "${aws_api_gateway_stage.deployment_stage.invoke_url}/${aws_api_gateway_resource.date.path_part}"
  sensitive = false
}