# request-bucket and response-bucket
provider "aws" {
  region = "eu-north-1"
}

resource "aws_s3_bucket" "request_bucket" {
  bucket = var.request_bucket_name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket" "response_bucket" {
  bucket = var.response_bucket_name

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
