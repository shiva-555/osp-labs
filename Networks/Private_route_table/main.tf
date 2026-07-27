
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = local.private_route_table_name
  }
}


################## association private route table with private subnet ##################

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = var.private_subnet_1_id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = var.private_subnet_2_id
  route_table_id = aws_route_table.private.id
}
