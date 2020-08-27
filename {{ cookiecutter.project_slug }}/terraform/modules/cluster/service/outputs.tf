output "ecr_arn" {
  value = aws_ecr_repository.ecr_repo.arn
}
output "ecr_url" {
  value = aws_ecr_repository.ecr_repo.repository_url
}
