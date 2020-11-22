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

  tags = merge(
    var.default_tags, 
    var.vpc.tags, {
        Name = "rt-${var.vpc.region_alias}"
        Region_Id = var.vpc.region
        Environment = var.env
  })
}

resource "aws_route" "ingress_access" {
  count = var.with_internet_access ? 1 : 0

  route_table_id            = aws_route_table.rt.id
  gateway_id = aws_internet_gateway.ig[0].id
  destination_cidr_block    = "0.0.0.0/0"
  # vpc_peering_connection_id = "pcx-45ff3dc1"
  depends_on                = [aws_route_table.rt, aws_internet_gateway.ig]
}

resource "aws_main_route_table_association" "rta" {
  vpc_id         = var.vpc.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_internet_gateway" "ig" {
  count = var.with_internet_access ? 1 : 0

  vpc_id = var.vpc.id
  tags = merge(
    var.default_tags,
    {
      Name = "ig-${var.vpc.region_alias}"
      Region_Id = var.vpc.region
      Environment = var.env
    }
  )
}
