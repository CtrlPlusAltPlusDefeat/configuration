
resource "aws_dynamodb_table" "game_session_table" {
  billing_mode   = "PROVISIONED"

  name           = "GameSession"
  hash_key       = "LobbyId"
  range_key      = "GameSessionId"

  read_capacity  = 2
  write_capacity = 2

  attribute {
    name = "LobbyId"
    type = "S"
  }

  attribute {
    name = "GameSessionId"
    type = "S"
  }
}