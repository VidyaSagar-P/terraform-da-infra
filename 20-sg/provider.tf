terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.42.0"
    }
  }
  backend "s3" {
    bucket         = "jyo1994-vs-terraform"
    key            = "da-sg"
    region         = "us-east-1"
    dynamodb_table = "terraform-practice"
  }
}

provider "aws" {
  region = "us-east-1"
}