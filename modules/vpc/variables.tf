variable "env" {
  description = "Set env"
  type = string

  validation {
    condition     = can(regex("^(dev)$|^(staging)$|^(uat)$|^(prod)$", var.env))
    error_message = "💥 Env must be one of these values: dev|staging|uat|prod."
  }
}

variable "region" {
  description = "AWS Region"
  type = string
}

variable "vpc_cidr_block" {
  description = "Define CIDR block"
  type = string
}

variable "tags" {
  description = "Tags to set on VPC"
  type = map(string)
  default = {}
}
