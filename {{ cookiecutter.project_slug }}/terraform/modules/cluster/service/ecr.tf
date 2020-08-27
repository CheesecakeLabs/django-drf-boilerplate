resource "aws_ecr_repository" "ecr_repo" {
  name = "${var.project_name}-${var.alias_name}/${var.environment}"

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = var.alias_name
  }
}