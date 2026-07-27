locals {
  public_route_table_name = "${var.project_name}-${var.vpc_name}-${var.public_subnet_name}-${var.public_route_table_name}"
}
