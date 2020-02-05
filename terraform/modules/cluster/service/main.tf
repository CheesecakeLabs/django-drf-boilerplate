resource "aws_ecs_service" "service" {
  name = "${var.project_name}-${var.alias_name}-${var.environment}"
  cluster = var.cluster_id
  task_definition = aws_ecs_task_definition.main_td.arn
  launch_type = "EC2"
  desired_count = var.task_count
  deployment_minimum_healthy_percent = 50
  iam_role = var.service_role.name

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "instanceId"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.tg.arn
    container_name = "${var.project_name}-${var.alias_name}-${var.environment}"
    container_port = var.container_port
  }

  depends_on = [
    var.lb_listener_http,
    var.lb_listener_https,
    aws_lb_target_group.tg,
  ]
}

data "template_file" "main_container" {
  template = file(var.task_definition_file)

  vars = merge(var.container_env_vars, {
    aws_region = var.region
    container_name = "${var.project_name}-${var.alias_name}-${var.environment}"
    cloudwatch_log_group = aws_cloudwatch_log_group.logs.name
    container_image = "${aws_ecr_repository.ecr_repo.repository_url}:latest"
  })
}

resource "aws_ecs_task_definition" "main_td" {
  family = "${var.project_name}-${var.alias_name}-${var.environment}"
  requires_compatibilities = ["EC2"]
  network_mode = var.has_service_discovery ? "awsvpc" : "bridge"
  container_definitions = data.template_file.main_container.rendered

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = var.alias_name
  }
}
