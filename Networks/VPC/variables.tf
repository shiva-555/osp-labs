variable "project_name" {
  description = "project name for which infra develop"
}

#### vpc variables ###### 

variable "cidr_block" {
  description = "This is the cidr range for the vpc of osp-labs"
  type        = string
}

variable "vpc_name" {
  type        = string
  description = "we are giving the vpc name as a main which is also vpc resource type name as well"
}

variable "enable_dns" {
  description = "enabling the dns support for the vpc"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "enabling the dns hostname for the vpc"
  type        = bool
}


