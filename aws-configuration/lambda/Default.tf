resource "aws_lambda_function" "default_function" {
  function_name    = "default"
  package_type     = "Zip"
  runtime          = "go1.x"
  handler          = "main"

  filename         = "./lambda/_code.zip"

  role             = data.aws_iam_role.lambda_iam_role.arn

  timeout          = 30
  memory_size      = 128

  layers           = [ data.aws_lambda_layer_version.lambda_secretsmanager_layer.arn ]
  
  vpc_config {
    subnet_ids         = local.subnet_ids
    security_group_ids = [data.aws_security_group.lambda_security.id]
  }

  #lifecycle {
  #  ignore_changes = [
  #    filename
  #  ]
  #}

  provider = aws.europe_london
}

resource "aws_lambda_function_event_invoke_config" "default_function_config" {
  function_name                = aws_lambda_function.default_function.function_name
  maximum_event_age_in_seconds = 60
  maximum_retry_attempts       = 2

  provider = aws.europe_london
}