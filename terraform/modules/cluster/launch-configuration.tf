data "aws_ami" "ecs-optimized" {
  most_recent = true

  filter {
    name = "name"
    values = ["amzn-ami*amazon-ecs-optimized"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["591542846629"] # AWS
}

resource "aws_launch_configuration" "lc" {
  name_prefix = "${var.project_name}-${var.environment}"
  image_id = data.aws_ami.ecs-optimized.id
  instance_type = var.instance_type
  security_groups = [var.public_secutity_group_id, var.private_secutity_group_id]
  iam_instance_profile = var.ecs_instance_profile_id
  user_data = <<EOF
      #!/bin/bash
      echo ECS_CLUSTER=${aws_ecs_cluster.cluster.name} >> /etc/ecs/ecs.config
      EOF

  # aws_launch_configuration can not be modified.
  # Therefore we use create_before_destroy so that a new modified aws_launch_configuration can be created
  # before the old one get's destroyed. That's why we use name_prefix instead of name.
  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_type = "standard"
    volume_size = 40 #The latest ami snapshot needs more than 30GB to create the EC2 instance
    delete_on_termination = true
  }
}
