locals {
  public_subnet_name  = "${var.project_name}-${var.vpc_name}-${var.public_subnet_name}"
  private_subnet_name = "${var.project_name}-${var.vpc_name}-${var.private_subnet_name}"
}
