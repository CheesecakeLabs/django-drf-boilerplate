output "bucket" {
  value = aws_s3_bucket.terraform_state.bucket
}
output "dynamodb_table" {
  value = aws_dynamodb_table.terraform-locks.name
}
