variable "project_name" {
  description = "project name"
}

variable "vpc_name" {
  description = "taking the reference from the VPC/output.tf"
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_1_cidr" {
  description = "this is cidr range for the public subnet"
}

variable "public_subnet_2_cidr" {
  description = "this is cidr range for the public subnet"
}

variable "public_subnet_name" {
  description = "public subnet name we have given in tfvars"
}

variable "internet_gw_id" {
  description = "taking this id as output of the Internet_gw_module"
}

variable "public_route_table_name" {
  description = "public route table name we are giving in tfvars"
}

variable "public_subnet_1_id" {
  type = string
}

variable "public_subnet_2_id" {
  type = string
}
