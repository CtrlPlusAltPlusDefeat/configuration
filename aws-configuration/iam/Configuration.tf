resource "aws_iam_user" "configuration" {
  name     = "Configuration"

  provider = aws.europe_london
}

resource "aws_iam_access_key" "configuration_access_key" {
  user     = aws_iam_user.configuration.name

  provider = aws.europe_london
}

output "configuration_access_key" {
  value = aws_iam_access_key.configuration_access_key.id
}

output "configuration_secret_access_key" {
  value = aws_iam_access_key.configuration_access_key.secret
}

resource "aws_iam_user_policy" "configuration_policy_s3" {
  name     = "configuration-s3"
  user     = aws_iam_user.configuration.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "s3:*"
        ],
      "Effect": "Allow",
      "Resource": [
          "*"
        ]
    }
  ]
}
EOF

  provider = aws.europe_london
}

resource "aws_iam_user_policy" "configuration_policy_iam" {
  name     = "configuration-iam"
  user     = aws_iam_user.configuration.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "iam:*"
        ],
      "Effect": "Allow",
      "Resource": [
          "*"
        ]
    }
  ]
}
EOF

  provider = aws.europe_london
}