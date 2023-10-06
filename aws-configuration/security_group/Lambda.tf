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
  

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    self = true
  }

  provider = aws.europe_london
}
