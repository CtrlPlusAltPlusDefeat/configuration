terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
      configuration_aliases = [
        aws.europe_london,
        aws.north_america_north_virginia
      ]
    }
  }

}