resource "aws_lambda_function" "disconnect_function" {
  function_name    = "disconnect"
  package_type     = "Zip"
  runtime          = "go1.x"
  handler          = "main"

  filename         = "./lambda/_code.zip"

  role             = data.aws_iam_role.lambda_iam_role.arn

  timeout          = 5
  memory_size      = 128

  layers           = [ data.aws_lambda_layer_version.lambda_secretsmanager_layer.arn ]

  provider = aws.europe_london
}

resource "aws_lambda_function_event_invoke_config" "disconnect_function_config" {
  function_name                = aws_lambda_function.disconnect_function.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 1

  provider = aws.europe_london
}

resource "aws_cloudwatch_log_group" "disconnect_function_logs" {
  name              = "/aws/lambda/${aws_lambda_function.disconnect_function.function_name}"
  retention_in_days = 14

  provider = aws.europe_london
}