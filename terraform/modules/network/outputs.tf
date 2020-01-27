output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "private_subnet_2_id" {
  value = aws_subnet.private_subnet_2.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "public_subnet_2_id" {
  value = aws_subnet.public_subnet_2.id
}

output "public_secutity_group_id" {
  value = aws_security_group.public_secutity_group.id
}

output "private_secutity_group_id" {
  value = aws_security_group.private_secutity_group.id
}
