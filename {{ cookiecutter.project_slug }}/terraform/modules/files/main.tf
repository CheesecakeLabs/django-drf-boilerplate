resource "aws_s3_bucket" "app_bucket" {
  bucket = "{{ cookiecutter.project_name }}-${var.environment}"
  acl = "public-read"

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = {{ cookiecutter.project_name }}
    "ckl:alias" = "app"
  }
}
