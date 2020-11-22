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
  region = var.vpc.region
}

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc.cidr_block
  
  tags = merge(
    var.default_tags, 
    var.vpc.tags, {
       Name = "vpc-${var.vpc.region_alias}"
       Region_Id = var.vpc.region
       Environment = var.env
    })
}