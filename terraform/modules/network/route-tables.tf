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

# Create Route table for subnets with internet gateway
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
resource "aws_route_table_association" "public_subnet_1_rt_a" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "public_subnet_2_rt_a" {
  subnet_id = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.rt.id
}

# Associate Route table with private subnets
resource "aws_route_table_association" "private_subnet_rt_a" {
  subnet_id = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "private_subnet_2_rt_a" {
  subnet_id = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.rt.id
}
