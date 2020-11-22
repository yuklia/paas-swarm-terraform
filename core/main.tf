module "vpc-eu-paris" {
  source = "../modules/vpc"

  env = var.env
  vpc = {
     region=var.vpc_paris.region, 
     region_alias=var.vpc_paris.region_alias,
     cidr_block=var.vpc_paris.cidr_block,
     tags=var.vpc_paris.tags
  }
}

# resource "aws_main_route_table_association" "a" {
#   vpc_id         = aws_vpc.foo.id
#   route_table_id = aws_route_table.bar.id
# }

module "vpc-usa-oregon" {
  source = "../modules/vpc"

  env = var.env
  vpc = {
     region=var.vpc_oregon.region, 
     region_alias=var.vpc_oregon.region_alias,
     cidr_block=var.vpc_oregon.cidr_block,
     tags=var.vpc_oregon.tags
  }
}
