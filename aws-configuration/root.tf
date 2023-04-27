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
  
  backend "s3" {
    bucket     = "ctrlplusaltplusdefeat-configuration"
    key        = "terraform.tfstate"

    encrypt    = true
  }
}

module "s3" {
  source = "./s3"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "iam" {
  source = "./iam"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "iam_role" {
  source = "./iam_role"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "cloudfront" {
  source = "./cloudfront"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "lambda" {
  source = "./lambda"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "security_group" {
  source = "./security_group"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "apigateway" {
  source = "./apigateway"

  providers = {
    aws.europe_london = aws.europe_london
  }
}

module "dynamodb" {
  source = "./dynamodb"

  providers = {
    aws.europe_london = aws.europe_london
  }
}