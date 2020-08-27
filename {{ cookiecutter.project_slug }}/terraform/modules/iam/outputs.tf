output "ecs-service-role" {
  value = aws_iam_role.ecs-service-role
}
output "ecs-instance-role" {
  value = aws_iam_role.ecs-instance-role
}
output "ecs-instance-profile" {
  value = aws_iam_instance_profile.ecs-instance-profile
}
output "deploy_access_key_id" {
  value = aws_iam_access_key.deploy.id
}
output "deploy_access_key_secret" {
  value = aws_iam_access_key.deploy.secret
}
