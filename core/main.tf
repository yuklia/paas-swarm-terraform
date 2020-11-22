#----------------OREGON START---------------------
#-------------------------------------------------


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

module "rt_oregon_external_load_balancer" {
  source = "../modules/route-table"

  env = var.env
  with_internet_access = true
  vpc = {
     id = module.vpc-usa-oregon.vpc_id,
     region = var.vpc_oregon.region,
     region_alias = var.vpc_oregon.region_alias
     tags = {}
  }
  subnets = var.vpc_oregon.public_subnets
}

module "rt_oregon_app" {
  source = "../modules/route-table"

  env = var.env
  with_internet_access = false
  vpc = {
     id = module.vpc-usa-oregon.vpc_id,
     region = var.vpc_oregon.region,
     region_alias = var.vpc_oregon.region_alias
     tags = {}
  }
  subnets = var.vpc_oregon.private_subnets
}

#----------------OREGON END---------------------
#-----------------------------------------------

#----------------PARIS START---------------------
#------------------------------------------------

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

module "rt_paris_app" {
  source = "../modules/route-table"

  env = var.env
  with_internet_access = false
  vpc = {
     id = module.vpc-eu-paris.vpc_id,
     region = var.vpc_paris.region,
     region_alias = var.vpc_paris.region_alias
     tags = {}
  }
  subnets = var.vpc_paris.private_subnets
}

#----------------PARIS END---------------------
#----------------------------------------------