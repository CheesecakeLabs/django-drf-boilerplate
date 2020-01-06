resource "aws_iam_role" "ecs-service-role" {
  name = "${var.project_name}-ECS-Service-Role"
  assume_role_policy = data.aws_iam_policy_document.ecs-service-policy.json
  tags = {
    "ckl:project" = var.project_name
    "ckl:alias" = "deploy-user"
  }
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role = aws_iam_role.ecs-service-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}

data "aws_iam_policy_document" "ecs-service-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs-instance-role" {
  name = "${var.project_name}-${var.environment}-ecs-instance-role"
  path = "/"
  assume_role_policy  = data.aws_iam_policy_document.ecs-instance-policy.json
}

data "aws_iam_policy_document" "ecs-instance-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs-instance-role-attachment" {
  role = aws_iam_role.ecs-instance-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs-instance-profile" {
  name = "${var.project_name}-${var.environment}-ecs-instance-profile"
  path = "/"
  role = aws_iam_role.ecs-instance-role.id
}

data "aws_iam_policy_document" "app_bucket_policy_document" {
  statement {
    sid = ""
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      "arn:aws:s3:::${var.app_bucket.bucket}"
    ]
  }
  statement {
    sid = ""
    effect = "Allow"
    actions = [
      "s3:DeleteObject",
      "s3:GetObject",
      "s3:PutObject",
      "s3:PutObjectAcl"
    ]
    resources = [
      "arn:aws:s3:::${var.app_bucket.bucket}/*"
    ]
  }
}

resource "aws_iam_policy" "app_bucket_policy" {
  name = "${var.project_name}-s3-policy-${var.environment}"
  policy = data.aws_iam_policy_document.app_bucket_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ecs_service_role_app_bucket_policy_attach" {
  role = aws_iam_role.ecs-service-role.name
  policy_arn = aws_iam_policy.app_bucket_policy.arn
}
