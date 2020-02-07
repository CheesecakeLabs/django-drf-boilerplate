output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "public_security_group_id" {
  value = aws_security_group.public_security_group.id
}

output "private_security_group_id" {
  value = aws_security_group.private_security_group.id
}

output "database_security_group_id" {
  value = aws_security_group.database_security_group.id
}
