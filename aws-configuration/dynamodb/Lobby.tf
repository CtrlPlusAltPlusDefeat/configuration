
resource "aws_dynamodb_table" "lobby_table" {
  billing_mode   = "PROVISIONED"

  name           = "Lobby"
  hash_key       = "LobbyId"

  read_capacity  = 2
  write_capacity = 2

  attribute {
    name = "LobbyId"
    type = "S"
  }
}