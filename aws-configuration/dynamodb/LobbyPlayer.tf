
resource "aws_dynamodb_table" "lobby_player_table" {
  billing_mode   = "PROVISIONED"

  name           = "LobbyPlayer"
  hash_key       = "LobbyId"
  range_key      = "SessionId"

  read_capacity  = 2
  write_capacity = 2

  attribute {
    name = "LobbyId"
    type = "S"
  }

  attribute {
    name = "SessionId"
    type = "S"
  }
}