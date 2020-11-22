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

module "main_rt_paris" {
  source = "../modules/route-table"

  env = var.env
  vpc = {
     id = module.vpc-eu-paris.vpc_id,
     region = var.vpc_paris.region,
     region_alias = var.vpc_paris.region_alias
     tags = {}
  }
}

module "main_rt_oregon" {
  source = "../modules/route-table"

  env = var.env
  with_internet_access = var.vpc_oregon.with_internet_access
  vpc = {
     id = module.vpc-usa-oregon.vpc_id,
     region = var.vpc_oregon.region,
     region_alias = var.vpc_oregon.region_alias
     tags = {}
  }
}

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
