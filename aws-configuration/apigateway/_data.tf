data "aws_iam_role" "apigateway_iam_role" {
  name = "APIGatewayExecution"

  provider = aws.europe_london
}

data "aws_lambda_function" "disconnect_function" {
  function_name = "disconnect"

  provider = aws.europe_london
}

data "aws_lambda_function" "connect_function" {
  function_name = "connect"

  provider = aws.europe_london
}

data "aws_lambda_function" "default_function" {
  function_name = "default"

  provider = aws.europe_london
}