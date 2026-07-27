output "eks_cluster_role_name" {
  value = aws_iam_role.eks_cluster_role.name
}

output "eks_cluster_role_arn" {
  description = "EKS Cluster IAM Role ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}
