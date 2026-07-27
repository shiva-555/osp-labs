output "node_group_name" {
  value = aws_eks_node_group.managed_node_group.node_group_name
}

output "node_group_arn" {
  value = aws_eks_node_group.managed_node_group.arn
}

output "node_group_status" {
  value = aws_eks_node_group.managed_node_group.status
}
