data "aws_s3_bucket" "site_s3" {
  bucket   = "ctrlplusaltplusdefeat-site"

  provider = aws.europe_london
}