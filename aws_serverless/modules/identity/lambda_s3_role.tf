resource "aws_iam_role" "role_lambda_s3_integration" {
  name               = var.role_lambda_s3_bucket_access
  assume_role_policy = data.aws_iam_policy_document.amazon_lambda_assume_role_policy.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "s3_policy_attach" {
  role       = aws_iam_role.role_lambda_s3_integration.name
  policy_arn = aws_iam_policy.policy_lambda_s3_integration.arn
}


data "aws_iam_policy_document" "amazon_lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}