resource "aws_autoscaling_group" "asg" {
  name_prefix = "${var.project_name}-${var.environment}"
  max_size = var.max_instances
  min_size = var.min_instances
  desired_capacity = var.desired_instances
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier = [var.private_subnet_1_id, var.private_subnet_2_id]
  health_check_type = "EC2"

  tag {
    key = "Name"
    propagate_at_launch = true
    value = "${var.project_name}-${var.environment}-ECS-Instance"
  }

  tag {
    key = "ckl:project"
    propagate_at_launch = true
    value = var.project_name
  }

  tag {
    key = "ckl:environment"
    propagate_at_launch = true
    value = var.environment
  }

  tag {
    key = "ckl:alias"
    propagate_at_launch = true
    value = "${var.project_name}-${var.environment}-instance"
  }
}
