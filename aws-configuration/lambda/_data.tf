locals {
  subnet_ids = ["subnet-0c13306ed1110d72b", "subnet-0924e5edbe03c3150", "subnet-04ae8c6987e2cc906"]
}

data "aws_iam_role" "lambda_iam_role" {
  name = "LambdaExecution"

  provider = aws.europe_london
}

data "aws_security_group" "lambda_security" {
  name = "Lambda"

  provider = aws.europe_london
} 