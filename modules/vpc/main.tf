variable "default_tags" {
  type = map(string)
  default = {
     Terraform  = "true"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
  shared_credentials_file = "/Users/yulia/.aws/credentials"
  profile                 = "waeve"
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = merge(
    var.default_tags, 
    var.tags, {
       Name = "vpc-${var.region}"
       Environment = var.env
    })
}