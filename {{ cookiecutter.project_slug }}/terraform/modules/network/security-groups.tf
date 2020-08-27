resource "aws_security_group" "public_security_group" {
  name = "${var.project_name}-${var.environment}-public"
  description = "Public access from HTTP and HTTPS"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

resource "aws_security_group" "private_security_group" {
  name = "${var.project_name}-${var.environment}-private"
  description = "Private access allowed from public security group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [
      aws_security_group.public_security_group.id
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}

resource "aws_security_group" "database_security_group" {
  name = "${var.project_name}-${var.environment}-database"
  description = "Private access allowed from private security group"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    security_groups = [
      aws_security_group.private_security_group.id
    ]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}
