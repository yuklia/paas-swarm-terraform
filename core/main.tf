module "vpc-eu-paris" {
  source = "../modules/vpc"

  region = var.region_paris
  vpc_cidr_block = var.vpc_cidr_paris
  env = var.env
  tags = {}
}

module "vpc-usa-origon" {
  source = "../modules/vpc"

  region = var.region_oregon
  vpc_cidr_block = var.vpc_cidr_oregon
  env = var.env
  tags = {}
}
