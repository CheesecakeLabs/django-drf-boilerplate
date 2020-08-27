variable "region" {
  default = "us-west-2"
}
variable "aws_profile" {
  default = "staging"
}
variable "project_name" {
  description = "Our project name"
}
variable "availability_zone_1" {
  default = "a"
}
variable "availability_zone_2" {
  default = "b"
}
variable "cluster_instance_type" {
  description = "The type of EC2 instance used on the cluster. ex: (t2.micro, t2.small...)"
  default = "t3.micro"
}
variable "cluster_desired_instances" {
  description = "Amount of EC2 instances are desired for the autoscaling"
  default = 1
}
variable "cluster_max_instances" {
  description = "Max EC2 instances in autoscaling"
  default = 1
}
variable "cluster_min_instances" {
  description = "Min EC2 instances in autoscaling"
  default = 0
}
variable "db_username" {
  description = "Database root username"
}
variable "db_password" {
  description = "Database password"
}
variable "db_storage_size" {
  description = "Database instance storage allocation space"
  default = 21
}
variable "db_instance_type" {
  description = "The type of EC2 instance used for database. ex: (t2.micro, t2.small...)"
  default = "db.t3.micro"
}
variable "domains" {
  description = "Domains of each service that is used on ALB requests forwarding"
  default = {
    apex = "example.com",
    backend = "api.example.com",
    frontend = "example.com"
  }
}

variable "backend_secret_key" {}
variable "backend_email_from" {}
variable "public_key" {}
