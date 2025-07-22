terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.3.0"
    }
  }
  backend "s3" {
    bucket  = "iac-state-bucket-nanook"
    region  = "us-east-2"
    key     = "terraform.tfstate"
    encrypt = true

    
  }
}

provider "aws" {
  region  = "us-east-2"
  profile = "AdministratorAccess-442042528695"
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = var.state_bucket

  lifecycle {
    prevent_destroy = true
  }
}

  resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [aws_s3_bucket.terraform_state]
}