resource "aws_lb_target_group" "tg" {
  name  = "${var.project_name}-${var.alias_name}-${var.environment}"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id

  health_check {
    path = var.health_check_path
  }

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "app"
  }
}

resource "aws_lb_listener_rule" "host_based_routing_http" {
  count = var.force_https_redirect ? 0 : 1
  listener_arn = var.lb_listener_http.arn

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    field = "host-header"
    values = [var.domain]
  }
}

resource "aws_lb_listener_rule" "https_force_redirect" {
  count = var.force_https_redirect ? 1 : 0
  listener_arn = var.lb_listener_http.arn

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    field = "host-header"
    values = [var.domain]
  }
}

resource "aws_lb_listener_rule" "host_based_routing_https" {
  listener_arn = var.lb_listener_https.arn

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }

  condition {
    field = "host-header"
    values = [var.domain]
  }
}
