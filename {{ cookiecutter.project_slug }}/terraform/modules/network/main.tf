resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    Name = "{{ cookiecutter.project_name }}-${var.environment}-vpc"
    "ckl:environment" = var.environment
    "ckl:project" = {{ cookiecutter.project_name }}
    "ckl:alias" = "network"
  }
}
