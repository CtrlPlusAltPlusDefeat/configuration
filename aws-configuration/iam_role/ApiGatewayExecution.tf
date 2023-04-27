resource "aws_iam_role" "apigateway_execution" {
  name = "APIGatewayExecution"
  assume_role_policy = data.aws_iam_policy_document.apigateway_execution_policy_document.json

  provider = aws.europe_london
}

resource "aws_iam_role_policy_attachment" "apigateway_execution_logging_policy" {
  role       = aws_iam_role.apigateway_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonAPIGatewayPushToCloudWatchLogs"

  provider = aws.europe_london
}

resource "aws_iam_role_policy_attachment" "apigateway_execution_lambda_policy" {
  role       = aws_iam_role.apigateway_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaRole"

  provider = aws.europe_london
}