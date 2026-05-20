terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.31.0"
    }
  }

  backend "s3" {
    bucket = "legacy-users-terraform-josealfredo"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region                   = var.aws_region
  skip_credentials_validation = true
  skip_requesting_account_id = true
}