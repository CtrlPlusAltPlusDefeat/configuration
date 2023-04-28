resource "aws_iam_user" "data" {
  name     = "Data"

  provider = aws.europe_london
}

resource "aws_iam_access_key" "data_access_key" {
  user     = aws_iam_user.data.name

  provider = aws.europe_london
}

output "data_access_key" {
  value = aws_iam_access_key.data_access_key.id
}

resource "aws_secretsmanager_secret" "data_access_key" {
  name = "DataAccessKey"
}

resource "aws_secretsmanager_secret_version" "data_access_key_version" {
  secret_id     = aws_secretsmanager_secret.data_access_key.id
  secret_string = aws_iam_access_key.data_access_key.id
}

output "data_secret_access_key" {
  value = aws_iam_access_key.data_access_key.secret
}

resource "aws_secretsmanager_secret" "data_secret_access_key" {
  name = "DataSecretAccessKey"
}

resource "aws_secretsmanager_secret_version" "data_secret_access_key_version" {
  secret_id     = aws_secretsmanager_secret.data_secret_access_key.id
  secret_string = aws_iam_access_key.data_access_key.secret
}

resource "aws_iam_user_policy" "data_policy_dynamodb" {
  name     = "data-dynamodb"
  user     = aws_iam_user.data.name
  policy   = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:UpdateItem",
                "dynamodb:GetItem",
                "dynamodb:Query",
            ],
            "Resource": "arn:aws:dynamodb:eu-west-2:847934878252:table/Connection"
        }
    ]
}
EOF

  provider = aws.europe_london
}