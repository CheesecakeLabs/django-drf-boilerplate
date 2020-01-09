output "db_hostname" {
  value = aws_db_instance.app_db.address
}
output "db_port" {
  value = aws_db_instance.app_db.port
}
output "db_username" {
  value = aws_db_instance.app_db.username
}
output "db_password" {
  value = aws_db_instance.app_db.password
}
output "db_name" {
  value = aws_db_instance.app_db.name
}
