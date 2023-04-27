resource "aws_iam_user" "terraform" {
  name     = "Terraform"

  provider = aws.europe_london
}

resource "aws_iam_access_key" "terraform_access_key" {
  user     = aws_iam_user.terraform.name

  provider = aws.europe_london
}

output "terraform_access_key" {
  value = aws_iam_access_key.terraform_access_key.id
}

output "terraform_secret_access_key" {
  value = aws_iam_access_key.terraform_access_key.secret
}

resource "aws_iam_user_policy" "terraform_policy_s3" {
  name     = "terraform-s3"
  user     = aws_iam_user.terraform.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
            "arn:aws:s3:::ctrlplusaltplusdefeat-configuration/terraform.tfstate",
            "arn:aws:s3:::ctrlplusaltplusdefeat-configuration"
      ]
    },
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

resource "aws_iam_user_policy" "terraform_policy_iam" {
  name     = "terraform-iam"
  user     = aws_iam_user.terraform.name
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

resource "aws_iam_user_policy" "terraform_policy_cloudfront" {
  name     = "terraform-cloudfront"
  user     = aws_iam_user.terraform.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "cloudfront:*"
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

resource "aws_iam_user_policy" "terraform_policy_lambda" {
  name     = "terraform-lambda"
  user     = aws_iam_user.terraform.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "lambda:*"
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

resource "aws_iam_user_policy" "terraform_policy_ec2" {
  name     = "terraform-ec2"
  user     = aws_iam_user.terraform.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "ec2:*"
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

resource "aws_iam_user_policy" "terraform_policy_apigateway" {
  name     = "terraform-apigateway"
  user     = aws_iam_user.terraform.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "apigateway:*"
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

resource "aws_iam_user_policy" "terraform_policy_dynamodb" {
  name     = "terraform-dynamodb"
  user     = aws_iam_user.terraform.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
          "dynamodb:*"
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