variable "project_name" {
  description = "project name"
}

variable "eks_cluster_name" {
  description = "getting reference from eks cluster as a output"
}

variable "node_group_name" {
  description = "This is the aws managed eks node group"
  type        = string
}

variable "node_group_role_arn" {
  type = string
}


variable "private_subnet_ids" {
  description = "we have taken this variable as an output from the module Subnetes"
  type        = list(string)
}

variable "instance_types" {
  type = list(string)
}

variable "capacity_type" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "desired_size" {
  type = number
}

variable "max_size" {
  type = number
}

variable "min_size" {
  type = number
}
