resource "aws_subnet" "public_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_1_cidr
  availability_zone = var.public_az_1
  tags = {
    Name = local.public_subnet_name
  }
}


resource "aws_subnet" "public_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnet_2_cidr
  availability_zone = var.public_az_2

  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-subnet-2"
  }
}

########## Private subnet ###########

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.private_az_1
  tags = {
    Name = local.private_subnet_name
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.private_az_2

  tags = {
    Name = "${var.project_name}-private-subnet-2"
  }
}
