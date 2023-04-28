resource "aws_iam_user" "backend" {
  name     = "Backend"

  provider = aws.europe_london
}

resource "aws_iam_access_key" "backend_access_key" {
  user     = aws_iam_user.backend.name

  provider = aws.europe_london
}

output "backend_access_key" {
  value = aws_iam_access_key.backend_access_key.id
}

resource "aws_secretsmanager_secret" "backend_access_key" {
  name = "BackendAccessKey"
}

resource "aws_secretsmanager_secret_version" "backend_access_key_version" {
  secret_id     = aws_secretsmanager_secret.backend_access_key.id
  secret_string = aws_iam_access_key.backend_access_key.id
}

output "backend_secret_access_key" {
  value = aws_iam_access_key.backend_access_key.secret
}

resource "aws_secretsmanager_secret" "backend_secret_access_key" {
  name = "BackendSecretAccessKey"
}

resource "aws_secretsmanager_secret_version" "backend_secret_access_key_version" {
  secret_id     = aws_secretsmanager_secret.backend_secret_access_key.id
  secret_string = aws_iam_access_key.backend_access_key.secret
}

resource "aws_iam_user_policy" "backend_policy_secretsmanager" {
  name     = "backend-secretsmanager"
  user     = aws_iam_user.backend.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetSecretValue"
      ],
      "Resource": [
        "arn:aws:secretsmanager:eu-west-2:847934878252:secret:BackendAccessKey*",
        "arn:aws:secretsmanager:eu-west-2:847934878252:secret:BackendSecretAccessKey*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

  provider = aws.europe_london
}

resource "aws_iam_user_policy" "backend_policy_dynamodb" {
  name     = "backend-dynamodb"
  user     = aws_iam_user.backend.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:PutItem",
        "dynamodb:DeleteItem",
        "dynamodb:UpdateItem",
        "dynamodb:GetItem",
        "dynamodb:Query",
        "dynamodb:Scan"
      ],
      "Resource": [
        "arn:aws:dynamodb:eu-west-2:847934878252:table/Connection"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

  provider = aws.europe_london
}