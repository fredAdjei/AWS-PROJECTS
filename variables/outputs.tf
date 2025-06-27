# Outputs (e.g., bucket names, Lambda ARN)
# ----------------------------------------------
# Output: Request Bucket Name
# Displays the name of the source S3 bucket used for input JSON files
# ----------------------------------------------
output "request_bucket_name" {
  description = "S3 bucket for original translation requests"
  value       = aws_s3_bucket.request_bucket.id
}

# ----------------------------------------------
# Output: Response Bucket Name
# Displays the name of the destination S3 bucket for translated output
# ----------------------------------------------
output "response_bucket_name" {
  description = "S3 bucket for translated responses"
  value       = aws_s3_bucket.response_bucket.id
}

# ----------------------------------------------
# Output: Lambda Function Name
# Useful for debugging, updates, or referencing programmatically
# ----------------------------------------------
output "lambda_function_name" {
  description = "Deployed Lambda function name"
  value       = aws_lambda_function.translator_lambda.function_name
}

# ----------------------------------------------
# Output: Lambda Function ARN
# Useful when integrating with other AWS services
# ----------------------------------------------
output "lambda_arn" {
  description = "ARN of the deployed Lambda function"
  value       = aws_lambda_function.translator_lambda.arn
}
