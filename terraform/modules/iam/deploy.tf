resource "aws_iam_user" "deploy-user" {
  name = "${var.project_name}_deploy_user"
  tags = {
    "ckl:project" = var.project_name
    "ckl:alias" = "app"
  }
}

resource "aws_iam_user_policy_attachment" "policy-attachment" {
  policy_arn = aws_iam_policy.deploy-policy.arn
  user = aws_iam_user.deploy-user.name
}

resource "aws_iam_policy" "deploy-policy" {
  name = "${var.project_name}_deploy_policy"
  policy = data.aws_iam_policy_document.ecs-deploy-policy.json
}

data "aws_iam_policy_document" "ecs-deploy-policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecs:DeregisterTaskDefinition",
      "ecs:DescribeServices",
      "ecs:DescribeTaskDefinition",
      "ecs:DescribeTasks",
      "ecs:ListTasks",
      "ecs:ListTaskDefinitions",
      "ecs:RegisterTaskDefinition",
      "ecs:StartTask",
      "ecs:StopTask",
      "ecs:UpdateService",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = ["ecr:*"]
    resources = var.ecr_list
  }
}

resource "aws_iam_access_key" "deploy" {
  user = aws_iam_user.deploy-user.name
}
