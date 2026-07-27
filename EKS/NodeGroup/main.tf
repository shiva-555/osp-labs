resource "aws_eks_node_group" "managed_node_group" {

  cluster_name    = var.eks_cluster_name
  node_group_name = local.node_group_name
  node_role_arn   = var.node_group_role_arn

  subnet_ids = var.private_subnet_ids

  scaling_config {
    desired_size = var.desired_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size

  ami_type = "AL2023_x86_64_STANDARD"

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = local.node_group_name
  }
}
