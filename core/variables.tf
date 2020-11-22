# Input variable definitions

variable "env" {
  description = "Infra environment"
  type        = string
  default     = "dev"
}

variable "vpc_paris" {
  description = "VPC object"
  type = object({
     region=string, 
     region_alias=string,
     cidr_block=string,
     with_internet_access = bool,
     tags=map(string)
  })
  default = {
    region = "eu-west-3",
    region_alias = "paris",
    cidr_block = "20.10.0.0/16",
    with_internet_access = false,
    tags = {"Label": "com.namespace.paris"}
  }
}

variable "vpc_oregon" {
  description = "VPC object"
  type = object({
     region=string, 
     region_alias=string,
     cidr_block=string,
     tags=map(string),
     public_subnets=object({
          count = number,
          cidr_block = list(string),
          az = list(string)
     }),
     private_subnets=object({
          count = number,
          cidr_block = list(string),
          az = list(string)
     })
  })
  default = {
    region = "us-west-2",
    region_alias = "oregon",
    cidr_block = "30.10.0.0/16",
    tags = {"Label": "com.namespace.oregon"},
    public_subnets = {
        count = 3,
        cidr_block = ["30.10.1.0/24", "30.10.2.0/24", "30.10.3.0/24"],
        az = ["us-west-2a", "us-west-2b", "us-west-2c"]
    },
    private_subnets = {
        count = 3,
        cidr_block = ["30.10.4.0/24", "30.10.5.0/24", "30.10.6.0/24"],
        az = ["us-west-2a", "us-west-2b", "us-west-2c"]
    }
  }
}

# variable "vpc_name" {
#   description = "Name of VPC"
#   type        = string
#   default     = "example-vpc"
# }

# variable "vpc_cidr" {
#   description = "CIDR block for VPC"
#   type        = string
#   default     = "10.0.0.0/16"
# }

# variable "vpc_azs" {
#   description = "Availability zones for VPC"
#   type        = list
#   default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
# }

# variable "vpc_private_subnets" {
#   description = "Private subnets for VPC"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24"]
# }

# variable "vpc_public_subnets" {
#   description = "Public subnets for VPC"
#   type        = list(string)
#   default     = ["10.0.101.0/24", "10.0.102.0/24"]
# }

# variable "vpc_enable_nat_gateway" {
#   description = "Enable NAT gateway for VPC"
#   type    = bool
#   default = true
# }

# variable "vpc_tags" {
#   description = "Tags to apply to resources created by VPC module"
#   type        = map(string)
#   default     = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }
