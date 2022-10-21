provider "aws" {
  region = "us-west-2"
}

# s3 bucket for this example only
resource "random_string" "random" {
  length  = 5
  special = false
  upper   = false
}

resource "aws_s3_bucket" "bucket" {
  bucket = "timestream-${random_string.random.id}"
}

resource "aws_s3_bucket_acl" "acl" {
  bucket = aws_s3_bucket.bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Timestream module example
module "timestream" {
  source        = "../../"
  database_name = "test"

  tables = [
    {
      table_name = "test"
    },
    {
      table_name = "test1"
      magnetic_store_writes = {
        enabled = true
        rejected_data_location = {
          bucket_name       = aws_s3_bucket.bucket.id
          encryption_option = "SSE_S3"
        }
      }
      retention_properties = {
        magnetic_store_retention_period_in_days = 3
        memory_store_retention_period_in_hours  = 24
      }
    }
  ]

}
