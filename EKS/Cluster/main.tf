resource "aws_eks_cluster" "eks_cluster" {

  name     = "${var.project_name}-${var.cluster_name}"
  role_arn = var.eks_cluster_role_arn

  vpc_config {

    subnet_ids = var.private_subnet_ids

    security_group_ids = [var.eks_cluster_security_group_id]


    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name = "${var.project_name}-${var.cluster_name}"
  }
}
