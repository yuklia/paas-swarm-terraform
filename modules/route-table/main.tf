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

### ------------------------------------------

# Create route table
resource "aws_route_table" "rt" {
  vpc_id = var.vpc.id

  # route {
  #   cidr_block = "10.0.1.0/24"
  #   gateway_id = aws_internet_gateway.main.id
  # }

  # route {
  #   ipv6_cidr_block        = "::/0"
  #   egress_only_gateway_id = aws_egress_only_internet_gateway.foo.id
  # }

  tags = merge(
  var.default_tags, 
  var.vpc.tags, {
      Name = "rt-${var.vpc.region_alias}"
      Region_Id = var.vpc.region
      Environment = var.env
  })
}

resource "aws_main_route_table_association" "rta" {
  vpc_id         = var.vpc.id
  route_table_id = aws_route_table.rt.id
}
