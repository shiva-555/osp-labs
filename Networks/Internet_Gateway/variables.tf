variable "project_name" {
  description = "project name"
}

variable "vpc_id" {
  type = string
}

variable "vpc_name" {
  description = "taking the reference from the VPC/output.tf"
}

variable "public_subnet_name" {
  description = "public subnet name we have given in tfvars"
}

variable "internet_gw_name" {
  type = string
}

