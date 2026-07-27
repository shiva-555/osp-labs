resource "aws_security_group" "cluster_sg" {

  name        = "${var.project_name}-eks-cluster-sg"
  description = "Security Group for EKS Cluster"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-eks-cluster-sg"
  }
}
