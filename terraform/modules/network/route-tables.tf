# Create  internet gateway to associate on route table
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}-${var.environment}-internet-gateway"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

# Create Route table for public subnets with internet gateway
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-igw-route-table"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

# Associate Route table with public subnets
resource "aws_route_table_association" "public_subnet_rt_a" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "public_subnet_2_rt_a" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rt.id
}


# Allocate an Elastic Ip
resource "aws_eip" "elastic_ip" {
  vpc = true

  tags = {
    Name = "${var.project_name}-${var.environment}-ip"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

# Create an Nat gateway with Elatic Ip
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = aws_subnet.public_subnet.id

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

# Create Route table for private subnets with nat gateway
resource "aws_route_table" "nat_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-nat-route-table"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "nat-route-table-with-nat"
  }
}

# Associate Route table with public subnets
resource "aws_route_table_association" "private_subnet_rt_a" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.nat_rt.id
}

resource "aws_route_table_association" "private_subnet_2_rt_a" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.nat_rt.id
}
