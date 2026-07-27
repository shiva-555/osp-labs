output "elastic_IP_allocationId" {
  value = aws_eip.nat_eip.allocation_id
}
