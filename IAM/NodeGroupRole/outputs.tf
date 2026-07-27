output "eks_node_group_role_arn" {
  description = "Node Group IAM Role ARN"
  value       = aws_iam_role.node_group_role.arn
}

output "eks_node_group_role_name" {
  description = "Node Group IAM Role Name"
  value       = aws_iam_role.node_group_role.name
}
