module "vpc" {
  source = "./Networks/VPC"

  project_name         = var.project_name
  cidr_block           = var.cidr_block
  vpc_name             = var.vpc_name
  enable_dns           = var.enable_dns
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "subnet" {
  source = "./Networks/Subnetes"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  vpc_name     = module.vpc.vpc_name

  public_subnet_1_cidr = var.public_subnet_1_cidr
  public_subnet_2_cidr = var.public_subnet_2_cidr

  private_subnet_1_cidr = var.private_subnet_1_cidr
  private_subnet_2_cidr = var.private_subnet_2_cidr

  public_az_1 = var.public_az_1
  public_az_2 = var.public_az_2

  private_az_1 = var.private_az_1
  private_az_2 = var.private_az_2

  public_subnet_name  = var.public_subnet_name
  private_subnet_name = var.private_subnet_name
}

############  Internet GW #################

module "Internet-GW" {

  source = "./Networks/Internet_Gateway"

  vpc_id             = module.vpc.vpc_id
  project_name       = var.project_name
  vpc_name           = module.vpc.vpc_name
  public_subnet_name = module.subnet.public_subnet_name
  internet_gw_name   = var.internet_gw_name
}


############## Public Route table & association with public subnet #################


module "Public-route-table" {

  source = "./Networks/Public_route_table"

  vpc_id                  = module.vpc.vpc_id
  project_name            = var.project_name
  vpc_name                = module.vpc.vpc_name
  public_subnet_name      = var.public_subnet_name
  public_subnet_1_cidr    = var.public_subnet_1_cidr
  public_subnet_2_cidr    = var.public_subnet_2_cidr
  public_subnet_1_id      = module.subnet.public_subnet_1_id
  public_subnet_2_id      = module.subnet.public_subnet_2_id
  internet_gw_id          = module.Internet-GW.internet_gw_id
  public_route_table_name = var.public_route_table_name

}

######################  elastic IP ########################

module "elastic_IP" {

  source = "./Networks/EIP"

  project_name = var.project_name
}

##########################  NatGateway ######################

module "NatGateway" {

  source = "./Networks/NatGateway"


  elastic_IP_allocationId = module.elastic_IP.elastic_IP_allocationId
  public_subnet_id        = module.subnet.public_subnet_1_id
  project_name            = var.project_name

}


########################## private Route table ########################

module "Private-route-table" {

  source = "./Networks/Private_route_table"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
  vpc_name     = module.vpc.vpc_name

  private_subnet_1_id = module.subnet.private_subnet_1_id
  private_subnet_2_id = module.subnet.private_subnet_2_id

  nat_gateway_id           = module.NatGateway.nat_gateway_id
  private_route_table_name = var.private_route_table_name
}


###################  IAM Role for EKSCLusterRole ###############

module "IAM_eks_cluster_role" {

  source = "./IAM/EKSClusterRole"

  project_name      = var.project_name
  cluster_role_name = var.cluster_role_name
}

#################### IAM role for NodeGroupRole ####################


module "IAM_eks_Node_Group_role" {

  source = "./IAM/NodeGroupRole"

  project_name         = var.project_name
  node_group_role_name = var.node_group_role_name
}


module "ebs_csi_role" {

  source = "./IAM/EBS-CSI-Role"

  project_name = var.project_name

  oidc_provider_arn = module.irsa.oidc_provider_arn

  oidc_provider_url = module.eks_cluster.oidc_provider_url
}


module "irsa" {

  source = "./IAM/IRSA"

  oidc_provider_url = module.eks_cluster.oidc_provider_url
}


################## Security Group ######################


module "eks_cluster_security_group" {

  source = "./SecurityGroups/EKS_Cluster_SG"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id
}


module "IAM_eks_Node_Group_security_group" {

  source = "./SecurityGroups/EKS_Node_Group_SG"

  project_name = var.project_name
  vpc_id       = module.vpc.vpc_id

}


################  EKS Cluster ####################

module "eks_cluster" {

  source = "./EKS/Cluster"

  project_name = var.project_name
  cluster_name = var.cluster_name

  eks_cluster_role_arn = module.IAM_eks_cluster_role.eks_cluster_role_arn

  eks_cluster_security_group_id = module.eks_cluster_security_group.eks_cluster_security_group_id

  private_subnet_ids = [
    module.subnet.private_subnet_1_id,
    module.subnet.private_subnet_2_id
  ]
}

################## Eks-managed node group ##########

module "eks_node_group" {

  source = "./EKS/NodeGroup"

  project_name = var.project_name

  eks_cluster_name = module.eks_cluster.eks_cluster_name

  node_group_name = var.node_group_name

  node_group_role_arn = module.IAM_eks_Node_Group_role.eks_node_group_role_arn

  private_subnet_ids = [
    module.subnet.private_subnet_1_id,
    module.subnet.private_subnet_2_id
  ]

  instance_types = var.instance_types

  capacity_type = var.capacity_type

  disk_size = var.disk_size

  desired_size = var.desired_size
  min_size     = var.min_size
  max_size     = var.max_size
}

########## eks addon ############

module "eks_addons" {

  source = "./EKS/AddOns"

  eks_cluster_name = module.eks_cluster.eks_cluster_name

  ebs_csi_role_arn = module.ebs_csi_role.ebs_csi_role_arn
}



