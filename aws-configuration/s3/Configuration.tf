resource "aws_s3_bucket" "configuration" {
  bucket   = "ctrlplusaltplusdefeat-configuration"

  provider = aws.europe_london
}

resource "aws_s3_bucket_server_side_encryption_configuration" "configuration_encryption" {
  bucket = aws_s3_bucket.configuration.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }

  provider = aws.europe_london
}

resource "aws_s3_bucket_versioning" "configuration_versioning" {
  bucket = aws_s3_bucket.configuration.id

  versioning_configuration {
    status = "Enabled"
  }

  provider = aws.europe_london
}

resource "aws_s3_bucket_policy" "configuration_policy" {
  bucket   = aws_s3_bucket.configuration.id
  policy   =  <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::ctrlplusaltplusdefeat-configuration/*",
            "Condition": {
              "StringNotEquals": {
                "s3:x-amz-server-side-encryption": "AES256"
              }
            }
        },
        {
            "Sid": "DenyUnEncryptedObjectUploads",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::ctrlplusaltplusdefeat-configuration/*",
            "Condition": {
              "Null": {
                "s3:x-amz-server-side-encryption": "true"
              }
            }
        },
        {
          "Sid": "AllowSSLRequestsOnly",
          "Effect": "Deny",
          "Principal": "*",
          "Action": "s3:*",
          "Resource": [
            "arn:aws:s3:::ctrlplusaltplusdefeat-configuration",
            "arn:aws:s3:::ctrlplusaltplusdefeat-configuration/*"
          ],
          "Condition": {
            "Bool": {
              "aws:SecureTransport": "false"
            }
          }
        }
    ]
}
POLICY

  provider = aws.europe_london
}

resource "aws_s3_bucket_public_access_block" "configuration_public_access_block" {
  bucket                  = aws_s3_bucket.configuration.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  provider = aws.europe_london
}