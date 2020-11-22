variable "env" {
  description = "Set env"
  type = string

  validation {
    condition     = can(regex("^(dev)$|^(staging)$|^(uat)$|^(prod)$", var.env))
    error_message = "💥 Env must be one of these values: dev|staging|uat|prod."
  }
}

variable "vpc" {
  description = "VPC object structure"
  type = object({
     region=string, 
     region_alias=string,
     cidr_block=string,
     tags=map(string)
  })
  default = {
    region = "",
    region_alias = "",
    cidr_block = "",
    tags = {}
  }
}

