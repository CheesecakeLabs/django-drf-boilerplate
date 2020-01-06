output "deploy_access_key_id" {
  value = module.iam.deploy_access_key_id
}
output "deploy_access_key_secret" {
  value = module.iam.deploy_access_key_secret
}
output "ecr_url_list" {
    value = module.cluster.ecr_url_list
}
output "lb_dns" {
    value = module.cluster.lb_dns
}
