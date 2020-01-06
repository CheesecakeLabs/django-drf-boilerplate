variable "environment" {}
variable "project_name" {}
variable "region" {}
variable "ecr_list" {
  default = []
  type = list(string)
}
variable app_bucket {}
