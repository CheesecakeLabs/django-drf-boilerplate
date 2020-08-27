# Private Subnets
resource "aws_subnet" "private_subnet_1" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.vpc.id
  availability_zone = "${var.region}${var.availability_zone_1}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "${var.region}${var.availability_zone_2}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-private-subnet-2"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "${var.region}${var.availability_zone_1}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}-public-subnet"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.region}${var.availability_zone_2}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-${var.environment}--public-subnet-2"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}
