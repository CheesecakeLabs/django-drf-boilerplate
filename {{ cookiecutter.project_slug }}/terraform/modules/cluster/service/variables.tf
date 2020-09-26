variable "region" {}
variable "vpc_id" {}
variable "environment" {}
variable "domain" {}
variable "alias_name" {}
variable "cluster_id" {}
variable "has_service_discovery" {}
variable "log_retention" {}
variable "task_count" {}
variable "container_port" {}
variable "service_role" {}
variable "lb_listener_http" {}
variable "lb_listener_https" {}
variable "task_definition_file" {}
variable "health_check_path" {
  default = "/"
}
variable "container_env_vars" {}
variable "force_https_redirect" {
  description = "This options will force the loadbalancer to redirect to HTTPS"
  type = bool
  default = false
}
