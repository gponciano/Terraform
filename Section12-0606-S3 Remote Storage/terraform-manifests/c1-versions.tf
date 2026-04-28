# Defines required Terraform version and AWS provider block

# Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

# Remote Backend
backend "s3" {
  bucket = "tfstate-dev-us-east-2-vsut8t"
  key = "vpc/dev/terraform.tfstate"
  region = "us-east-2"
  encrypt = true
  use_lockfile = true
  }
}

# Provider block
provider "aws" {
    region = var.aws_region
}