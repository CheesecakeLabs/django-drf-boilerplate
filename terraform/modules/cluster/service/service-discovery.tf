resource "aws_service_discovery_private_dns_namespace" "discovery" {
  count = var.has_service_discovery ? 1 : 0

  name = "${var.alias_name}.${var.project_name}-${var.environment}.local"
  vpc = var.vpc_id
}

resource "aws_service_discovery_service" "sd" {
  count = var.has_service_discovery ? 1 : 0
  
  name = "${var.project_name}-${var.alias_name}-${var.environment}"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.discovery[0].id
    dns_records {
      ttl = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
}
