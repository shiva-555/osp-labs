output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "eks_cluster_arn" {
  value = aws_eks_cluster.eks_cluster.arn
}

output "eks_cluster_endpoint" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "oidc_provider_url" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

output "oidc_issuer_hostpath" {
  value = replace(
    aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer,
    "https://",
    ""
  )
}
