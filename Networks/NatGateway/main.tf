resource "aws_nat_gateway" "nat" {
  allocation_id = var.elastic_IP_allocationId
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.project_name}- Nat-Gateway"
  }
}
