resource "aws_cloudfront_origin_access_identity" "site_identity" {
  provider = aws.europe_london
}

resource "aws_cloudfront_distribution" "site" {

  enabled         = true
  is_ipv6_enabled = true
  price_class     = "PriceClass_100"
  http_version    = "http2and3"

  default_root_object = "index.html"

  aliases         = [ ]

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  origin {
    domain_name = data.aws_s3_bucket.site_s3.bucket_regional_domain_name
    origin_id   = data.aws_s3_bucket.site_s3.bucket

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.site_identity.cloudfront_access_identity_path
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id       = data.aws_s3_bucket.site_s3.bucket
    viewer_protocol_policy = "redirect-to-https"

    compress    = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code         = "403"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = "404"
    response_code      = "200"
    response_page_path = "/index.html"
  }

  provider = aws.europe_london
}