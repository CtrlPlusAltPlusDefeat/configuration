provider "aws" {
  alias      = "europe_london"
  region     = "eu-west-2"

  default_tags {
    tags = {
      ManagedByTerraform = "true"
    }
  }
}

provider "aws" {
  alias      = "north_america_north_virginia"
  region     = "us-east-1"

  default_tags {
    tags = {
      ManagedByTerraform = "true"
    }
  }
}