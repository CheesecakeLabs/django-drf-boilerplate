output "ecr_list" {
  value = [
    module.backend.ecr_arn,
    module.frontend.ecr_arn
  ]
}
output "ecr_url_list" {
  value = [
    module.backend.ecr_url,
    module.frontend.ecr_url
  ]
}
output "lb_dns" {
  value = aws_lb.lb.dns_name
}
