resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.project_name}-${var.environment}"
  acl = "public-read"

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "app"
  }
}
