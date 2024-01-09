terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
  backend "s3" {
    bucket         = "terraform-tfstate-dev"
    key            = "provisioner"
    region         = "us-east-1"
    dynamodb_table = "terraform-tfstate-dev-locking"   
  }
}

provider "aws" {
  region = "us-east-1"
}


