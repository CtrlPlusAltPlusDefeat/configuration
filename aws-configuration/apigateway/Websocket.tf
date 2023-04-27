resource "aws_apigatewayv2_api" "websocket" {
  name                       = "websocket"
  protocol_type              = "WEBSOCKET"
  route_selection_expression = "$request.body.action"
}

# Disconnect Integration
resource "aws_apigatewayv2_integration" "websocket_disconnect_integration" {
  api_id                    = aws_apigatewayv2_api.websocket.id
  integration_type          = "AWS_PROXY"
  integration_uri           = data.aws_lambda_function.disconnect_function.invoke_arn
  credentials_arn           = data.aws_iam_role.apigateway_iam_role.arn
  content_handling_strategy = "CONVERT_TO_TEXT"
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_integration_response" "websocket_disconnect_integration_response" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  integration_id           = aws_apigatewayv2_integration.websocket_disconnect_integration.id
  integration_response_key = "/200/"
}

# Connect Integration
resource "aws_apigatewayv2_integration" "websocket_connect_integration" {
  api_id                    = aws_apigatewayv2_api.websocket.id
  integration_type          = "AWS_PROXY"
  integration_uri           = data.aws_lambda_function.connect_function.invoke_arn
  credentials_arn           = data.aws_iam_role.apigateway_iam_role.arn
  content_handling_strategy = "CONVERT_TO_TEXT"
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_integration_response" "websocket_connect_integration_response" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  integration_id           = aws_apigatewayv2_integration.websocket_connect_integration.id
  integration_response_key = "/200/"
}

# Default Integration
resource "aws_apigatewayv2_integration" "websocket_default_integration" {
  api_id                    = aws_apigatewayv2_api.websocket.id
  integration_type          = "AWS_PROXY"
  integration_uri           = data.aws_lambda_function.default_function.invoke_arn
  credentials_arn           = data.aws_iam_role.apigateway_iam_role.arn
  content_handling_strategy = "CONVERT_TO_TEXT"
  passthrough_behavior      = "WHEN_NO_MATCH"
}

resource "aws_apigatewayv2_integration_response" "websocket_default_integration_response" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  integration_id           = aws_apigatewayv2_integration.websocket_default_integration.id
  integration_response_key = "/200/"
}

# Disconnect Route
resource "aws_apigatewayv2_route" "websocket_disconnect_route" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  route_key                = "$disconnect"
  target                   = "integrations/${aws_apigatewayv2_integration.websocket_disconnect_integration.id}"
}

resource "aws_apigatewayv2_route_response" "websocket_disconnect_route_response" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  route_id                 = aws_apigatewayv2_route.websocket_disconnect_route.id
  route_response_key       = "$default"
}

# Connect Route
resource "aws_apigatewayv2_route" "websocket_connect_route" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  route_key                = "$connect"
  target                   = "integrations/${aws_apigatewayv2_integration.websocket_connect_integration.id}"
}

resource "aws_apigatewayv2_route_response" "websocket_connect_route_response" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  route_id                 = aws_apigatewayv2_route.websocket_connect_route.id
  route_response_key       = "$default"
}

# Default Route
resource "aws_apigatewayv2_route" "websocket_default_route" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  route_key                = "$default"
  target                   = "integrations/${aws_apigatewayv2_integration.websocket_default_integration.id}"
}

resource "aws_apigatewayv2_route_response" "websocket_default_route_response" {
  api_id                   = aws_apigatewayv2_api.websocket.id
  route_id                 = aws_apigatewayv2_route.websocket_default_route.id
  route_response_key       = "$default"
}

# Stage
resource "aws_apigatewayv2_stage" "websocket_stage" {
  api_id      = aws_apigatewayv2_api.websocket.id
  name        = "default"
  auto_deploy = true
}

# Permissions
resource "aws_lambda_permission" "websocket_disconnect_lambda_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.disconnect_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket.execution_arn}/*/*"
}

resource "aws_lambda_permission" "websocket_connect_lambda_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.connect_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket.execution_arn}/*/*"
}

resource "aws_lambda_permission" "websocket_default_lambda_permissions" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.default_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.websocket.execution_arn}/*/*"
}
