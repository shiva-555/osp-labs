variable "project_name" {
  description = "project name"
}

variable "eks_cluster_role_arn" {
  description = "we have taken this variable as an output from the IAM/EKSClusterRole"
}

variable "cluster_name" {
  description = "EKS cluster name"
}

variable "private_subnet_ids" {
  description = "we have taken this variable as an output from the module Subnetes"
  type        = list(string)
}

variable "eks_cluster_security_group_id" {
  description = "we have taken this variable as an output from the module Securitygroups/EKS_clusterSG"
}
