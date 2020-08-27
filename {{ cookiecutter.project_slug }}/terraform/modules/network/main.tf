resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "network"
  }
}
