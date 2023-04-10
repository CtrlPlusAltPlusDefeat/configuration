resource "aws_s3_bucket" "site" {
  bucket   = "ctrlplusaltplusdefeat-site"

  provider = aws.europe_london
}

resource "aws_s3_bucket_server_side_encryption_configuration" "site_encryption" {
  bucket = aws_s3_bucket.site.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }

  provider = aws.europe_london
}

resource "aws_s3_bucket_versioning" "site_versioning" {
  bucket = aws_s3_bucket.site.id

  versioning_configuration {
    status = "Enabled"
  }

  provider = aws.europe_london
}

resource "aws_s3_bucket_policy" "site_policy" {
  bucket   = aws_s3_bucket.site.id
  policy   =  <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PolicyForCloudFrontPrivateContent",
            "Effect": "Allow",
            "Principal": {
              "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E237COLFHZV8AY"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::ctrlplusaltplusdefeat-site/*"
        },
        {
            "Sid": "DenyIncorrectEncryptionHeader",
            "Effect": "Deny",
            "Principal": "*",
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::ctrlplusaltplusdefeat-site/*",
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
            "Resource": "arn:aws:s3:::ctrlplusaltplusdefeat-site/*",
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
            "arn:aws:s3:::ctrlplusaltplusdefeat-site",
            "arn:aws:s3:::ctrlplusaltplusdefeat-site/*"
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

resource "aws_s3_bucket_public_access_block" "site_public_access_block" {
  bucket                  = aws_s3_bucket.site.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  provider = aws.europe_london
}