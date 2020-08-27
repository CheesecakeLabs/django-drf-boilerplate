resource "aws_cloudwatch_log_group" "logs" {
  name = "${var.project_name}-${var.alias_name}-${var.environment}"
  retention_in_days = var.log_retention

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = var.alias_name
  }
}
