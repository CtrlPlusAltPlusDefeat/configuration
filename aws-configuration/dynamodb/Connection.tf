
resource "aws_dynamodb_table" "connection_table" {
  billing_mode   = "PROVISIONED"

  name           = "Connection"
  hash_key       = "ConnectionId"

  read_capacity  = 2
  write_capacity = 2

  attribute {
    name = "ConnectionId"
    type = "S"
  }

  attribute {
    name = "SessionId"
    type = "S"
  }

  global_secondary_index {
    name               = "SessionIdIndex"
    hash_key           = "SessionId"

    write_capacity     = 1
    read_capacity      = 1

    projection_type    = "ALL"
  }
}