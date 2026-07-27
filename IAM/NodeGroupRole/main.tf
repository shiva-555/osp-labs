
######## IAM role creation for the node group of the eks cluster 

resource "aws_iam_role" "node_group_role" {
  name = "${var.project_name}-${var.node_group_role_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

########## attach worker_node_policy to the node group IAM role ###########

resource "aws_iam_role_policy_attachment" "worker_node_policy" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

########## attach AmazonEC2ContainerRegistryReadOnly policy to the node group IAM role ###########
resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


########## attach AmazonEKS_CNI_Policy policy to the node group IAM role ########### 

resource "aws_iam_role_policy_attachment" "eks_cni" {
  role       = aws_iam_role.node_group_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
