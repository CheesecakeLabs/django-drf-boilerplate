resource "aws_ecr_repository" "ecr_repo" {
  name = "{{ cookiecutter.project_name }}-${var.alias_name}/${var.environment}"

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = {{ cookiecutter.project_name }}
    "ckl:alias" = var.alias_name
  }
}