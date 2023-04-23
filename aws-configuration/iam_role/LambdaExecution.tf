resource "aws_iam_role" "lambda_execution" {
  name = "LambdaExecution"
  assume_role_policy = data.aws_iam_policy_document.lambda_execution_policy_document.json

  provider = aws.europe_london
}

resource "aws_iam_role_policy_attachment" "lambda_execution_vpc_policy" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"

  provider = aws.europe_london
}