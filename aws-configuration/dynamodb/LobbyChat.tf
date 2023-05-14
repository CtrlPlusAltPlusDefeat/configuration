
resource "aws_dynamodb_table" "lobby_chat_table" {
  billing_mode   = "PROVISIONED"

  name           = "LobbyChat"
  hash_key       = "LobbyId"
  range_key      = "Timestamp"

  read_capacity  = 2
  write_capacity = 2

  attribute {
    name = "LobbyId"
    type = "S"
  }

  attribute {
    name = "Timestamp"
    type = "N"
  }
}