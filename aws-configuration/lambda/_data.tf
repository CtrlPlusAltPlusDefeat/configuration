data "aws_iam_role" "lambda_iam_role" {
  name = "LambdaExecution"

  provider = aws.europe_london
}

data "aws_lambda_layer_version" "lambda_secretsmanager_layer" {
  layer_name = "arn:aws:lambda:eu-west-2:133256977650:layer:AWS-Parameters-and-Secrets-Lambda-Extension"
  version    = 4

  provider = aws.europe_london
}