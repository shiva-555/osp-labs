# Create a VPC
resource "aws_vpc" "main" {

  cidr_block           = var.cidr_block
  enable_dns_support   = local.enable_dns
  enable_dns_hostnames = local.enable_dns_hostnames

  tags = {
    Name = "${var.project_name}-${var.vpc_name}"
  }

}
