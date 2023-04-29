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

resource "aws_iam_user_policy" "backend_policy_apigateway" {
  name     = "backend-apigateway"
  user     = aws_iam_user.backend.name
  policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "execute-api:ManageConnections"
      ],
      "Resource": [
        "arn:aws:execute-api:eu-west-2:847934878252:35hlhhl6z3/default/*/*"
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
        "arn:aws:dynamodb:eu-west-2:847934878252:table/Connection",
        "arn:aws:dynamodb:eu-west-2:847934878252:table/Connection/index/SessionIdIndex",
        "arn:aws:dynamodb:eu-west-2:847934878252:table/Lobby",
        "arn:aws:dynamodb:eu-west-2:847934878252:table/LobbyPlayer"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

  provider = aws.europe_london
}