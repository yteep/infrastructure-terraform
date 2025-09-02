resource "aws_iam_policy" "policy_lambda_s3_integration" {
  name = var.policy_lambda_s3_bucket_manage

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["s3:List*", "s3:Get*", "s3:PutObject"]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = var.tags
}