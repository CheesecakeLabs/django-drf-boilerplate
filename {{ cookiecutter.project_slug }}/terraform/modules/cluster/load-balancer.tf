resource "aws_lb" "lb" {
  name = "${var.project_name}-${var.environment}"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.public_security_group_id]
  subnets = [var.public_subnet_1_id, var.public_subnet_2_id]

  tags = {
    Name = "${var.project_name}-${var.environment}"
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "app"
  }
}

resource "aws_acm_certificate" "ssl" {
  domain_name = var.domains["apex"]
  subject_alternative_names = ["*.${var.domains["apex"]}"]
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = "80"
  protocol = "HTTP"

  # TODO: redirect to HTTPS when configured
  # default_action {
  #   type = "redirect"

  #   redirect {
  #     port        = "443"
  #     protocol    = "HTTPS"
  #     status_code = "HTTP_301"
  #   }
  # }
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Pong"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = aws_acm_certificate.ssl.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Pong"
      status_code  = "200"
    }
  }
}
