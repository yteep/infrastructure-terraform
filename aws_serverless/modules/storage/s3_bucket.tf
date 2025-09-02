resource "aws_s3_bucket" "s3_lambda_output" {
  bucket = var.bucket_name
  region = var.region
  force_destroy = true

  tags = var.tags
}