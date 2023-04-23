locals {
  subnet_ids = ["subnet-0d3bfdac5af4e9c71", "subnet-0d1bde86352e75b2b", "subnet-0c5a5cbd5a89085f1"]
}

data "aws_iam_role" "lambda_iam_role" {
  name = "LambdaExecution"

  provider = aws.europe_london
}

data "aws_security_group" "lambda_security" {
  name = "Lambda"

  provider = aws.europe_london
} 