variable "region" {
  description = "This is where we will setup the project"
}

####### vpc #################
variable "cidr_block" {
  type        = string
  description = "we are taking this value from the Network/variables.tf to pass in tfvars for the vpc cidr"
}

variable "vpc_name" {
  type        = string
  description = "we are giving the vpc name as a main which is also vpc resource type name as well"
}

variable "project_name" {
  type        = string
  description = "project name"
}

variable "enable_dns" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = true
}

############ AWS Subnet ###########

variable "public_subnet_1_cidr" {
  type = string
}
variable "public_subnet_2_cidr" {
  type = string
}
variable "private_subnet_1_cidr" {
  type = string
}
variable "private_subnet_2_cidr" {
  type = string
}
variable "public_subnet_name" {
  type = string
}

variable "private_subnet_name" {
  type = string
}

variable "public_az_1" {
  type = string
}

variable "public_az_2" {
  type = string
}

variable "private_az_1" {
  type = string
}

variable "private_az_2" {
  type = string
}

###########  Internet GW #############

variable "internet_gw_name" {
  type = string
}

############# Public Route Table ##########

variable "public_route_table_name" {
  type = string
}


############# Public Route Table ##########

variable "private_route_table_name" {
  type = string
}


############## IAM/EKSClusterRole #############

variable "cluster_role_name" {
  type = string
}

############## IAM/NodeGroupRole #############

variable "node_group_role_name" {
  type = string
}

#################EKS cluster Name##########

variable "cluster_name" {
  type = string
}

variable "instance_types" {
  description = "this is the Eks managed node group"
}

variable "node_group_name" {
  description = "This is the aws managed eks node group"
}

variable "capacity_type" {
  description = "This is capacity of the eks managed node group"
}

variable "disk_size" {
  description = "disk size"
}

variable "desired_size" {
  description = "desired node"
}

variable "max_size" {
  description = "max node"
}

variable "min_size" {
  description = "min node"
}
