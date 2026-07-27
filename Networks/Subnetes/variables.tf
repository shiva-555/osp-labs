variable "project_name" {
  description = "project name"
}

variable "public_subnet_1_cidr" {
  description = "this is cidr range for the public subnet"
}

variable "public_subnet_2_cidr" {
  description = "this is cidr range for the public subnet"
}

variable "public_az_1" {
  description = "public az1"
}

variable "public_az_2" {
  description = "public az2"
}

variable "vpc_name" {
  description = "taking the reference from the VPC/output.tf"
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_name" {
  description = "public subnet name we have given in tfvars"
}


################ Private subnet ###################

variable "private_subnet_1_cidr" {
  description = "this is cidr range for the public subnet"
}

variable "private_subnet_2_cidr" {
  description = "this is cidr range for the private subnet"
}

variable "private_subnet_name" {
  description = "private subnet name we have given in tfvars"
}

variable "private_az_1" {
  description = "private az1"
}

variable "private_az_2" {
  description = "private az2"
}
