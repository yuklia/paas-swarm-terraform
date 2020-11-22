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
  region = aws_vpc.
}

### ------------------------------------------

# Create route table
resource "aws_route_table" "r" {
  vpc_id = aws_vpc.default.id

  # route {
  #   cidr_block = "10.0.1.0/24"
  #   gateway_id = aws_internet_gateway.main.id
  # }

  # route {
  #   ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = aws_egress_only_internet_gateway.foo.id
  # }

  # tags = {
  #   Name = "main"
  # }
}
