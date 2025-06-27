# IAM role and policy for Lambda access
resource "aws_iam_role" "lambda_translate_role" {
  name = "lambda_translate_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_translate_policy" {
  name = "lambda_translate_policy"
  role = aws_iam_role.lambda_translate_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
     {
  Effect = "Allow",
  Action = [
    "s3:ListBucket",
    "s3:GetObject"
  ],
  Resource = [
    "arn:aws:s3:::${var.request_bucket_name}",
    "arn:aws:s3:::${var.request_bucket_name}/*"
  ]
}

      ,{
        Effect = "Allow",
        Action = [
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::${var.response_bucket_name}/*"
      },
      {
        Effect = "Allow",
        Action = [
          "translate:TranslateText"
        ],
        Resource = "*"
      },
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "*"
      }
    ]
  })
}

