resource "aws_iam_user" "github" {
  name     = "GitHub"

  provider = aws.europe_london
}

resource "aws_iam_access_key" "github_access_key" {
  user     = aws_iam_user.github.name

  provider = aws.europe_london
}

output "github_access_key" {
  value = aws_iam_access_key.github_access_key.id
}

output "github_secret_access_key" {
  value = aws_iam_access_key.github_access_key.secret
}

resource "aws_iam_user_policy" "github_policy_s3" {
  name     = "github-s3"
  user     = aws_iam_user.github.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:PutObject"
      ],
      "Resource": [
        "arn:aws:s3:::ctrlplusaltplusdefeat-site",
        "arn:aws:s3:::ctrlplusaltplusdefeat-site/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

  provider = aws.europe_london
}

resource "aws_iam_user_policy" "github_policy_cloudfront" {
  name     = "github-cloudfront"
  user     = aws_iam_user.github.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "cloudfront:CreateInvalidation",
        "cloudfront:ListInvalidations",
        "cloudfront:GetInvalidation"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

  provider = aws.europe_london
}

resource "aws_iam_user_policy" "github_policy_lambda" {
  name     = "github-lambda"
  user     = aws_iam_user.github.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "lambda:UpdateFunctionCode"
      ],
      "Resource": [
        "arn:aws:lambda:eu-west-2:847934878252:function:disconnect",
        "arn:aws:lambda:eu-west-2:847934878252:function:connect",
        "arn:aws:lambda:eu-west-2:847934878252:function:default"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

  provider = aws.europe_london
}