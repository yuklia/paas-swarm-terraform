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
        Name = "rt-${var.vpc.region_alias}_${var.with_internet_access ? "public" : "private"}"
        Region_Id = var.vpc.region
        Environment = var.env,
  })
}

# Connect VPC to Route table
resource "aws_main_route_table_association" "rta" {
  vpc_id         = var.vpc.id
  route_table_id = aws_route_table.rt.id
}

# Connect Route Table to internet
resource "aws_route" "ingress_access" {
  count = var.with_internet_access ? 1 : 0

  route_table_id            = aws_route_table.rt.id
  gateway_id = aws_internet_gateway.ig[0].id
  destination_cidr_block    = "0.0.0.0/0"
  depends_on                = [aws_route_table.rt, aws_internet_gateway.ig]
}

# Connect Route Table to internet
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

resource "aws_subnet" "sub" {
  count = var.subnets.count
  vpc_id     =  var.vpc.id
  cidr_block = var.subnets.cidr_block[count.index]
  availability_zone = var.subnets.az[count.index]

  tags = merge(
    var.default_tags,
    {
      Name = "${var.with_internet_access ? "public" : "private"}_${var.vpc.region_alias}_${var.subnets.az[count.index]}"
      Environment = var.env
    }
  )
}

resource "aws_route_table_association" "rta_subnets" {
  count = var.subnets.count

  subnet_id     = aws_subnet.sub[count.index].id
  route_table_id = aws_route_table.rt.id
}
