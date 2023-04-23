resource "aws_security_group" "lambda" {
  name        = "Lambda"
  description = "Allow all external and no internal."
  vpc_id      = local.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  provider = aws.europe_london
}