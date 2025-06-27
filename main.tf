# Core resources (S3 buckets, Lambda, permissions)
# Lambda & S3 Trigger
# ------------------------------------------------------
#  Lambda Function Definition
# Deploys the Python zip file and sets environment variable
resource "aws_lambda_function" "translator_lambda" {
  function_name = "translator_function"
  role          = aws_iam_role.lambda_translate_role.arn
  handler       = "translate_handler.lambda_handler"
  runtime       = "python3.11"
  timeout       = 15
  filename      = "${path.module}/lambda/translate.zip"

  environment {
    variables = {
      RESPONSE_BUCKET = var.response_bucket_name
    }
  }

  depends_on = [
    aws_iam_role_policy.lambda_translate_policy
  ]
}

# ------------------------------------------------------
# Lambda Permission
# Grants S3 permission to invoke Lambda
# ------------------------------------------------------
resource "aws_lambda_permission" "allow_s3_invoke" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.translator_lambda.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.request_bucket.arn
}

# ------------------------------------------------------
# S3 Push Notification Trigger
# Configures S3 to call Lambda when a new object is created
# ------------------------------------------------------
resource "aws_s3_bucket_notification" "s3_event_trigger" {
  bucket = aws_s3_bucket.request_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.translator_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [
    aws_lambda_permission.allow_s3_invoke
  ]
}
