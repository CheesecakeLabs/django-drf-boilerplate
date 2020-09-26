variable "environment" {}
variable "region" {}
variable "ecr_list" {
  default = []
  type = list(string)
}
variable app_bucket {}
