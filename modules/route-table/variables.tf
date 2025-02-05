variable "env" {
  description = "Set env"
  type = string

  validation {
    condition     = can(regex("^(dev)$|^(staging)$|^(uat)$|^(prod)$", var.env))
    error_message = "💥 Env must be one of these values: dev|staging|uat|prod."
  }
}

variable "with_internet_access" {
  description = ""
  type = bool
  default = false
}

variable "vpc" {
  description = "VPC object structure"
  type = object({
     id=string,
     region=string, 
     region_alias=string,
     tags = map(string)
  })
  default = {
    id = "",
    region = "",
    region_alias = "",
    tags = {}
  }
}

variable "subnets" {
   description = "Define subnets for route table."
   type = object({
      count = number,
      cidr_block = list(string),
      az = list(string)
   })
}
