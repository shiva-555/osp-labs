variable "project_name" {
  description = "project name"
}

variable "vpc_name" {
  description = "taking the reference from the VPC/output.tf"
}

variable "vpc_id" {
  type = string
}

variable "nat_gateway_id" {
  description = "taking the reference from the NatGateway/output.tf"
}

variable "private_route_table_name" {
  description = "public route table name we are giving in tfvars"
}

variable "private_subnet_1_id" {
  type = string
}

variable "private_subnet_2_id" {
  type = string
}
