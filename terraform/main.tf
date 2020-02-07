provider "aws" {
  profile = var.aws_profile
  region  = var.region
}

// We can't use interpolation in terraform block :(
terraform {
  backend "s3" {
    # Replace this with your Bucket name!
    #bucket = "#####(replace) tfstate bucket name. ${var.project_name}-terraform-state#####"
    bucket = "ckltftest-terraform-state"
    # Replace this with your DynamoDB table name!
    #dynamodb_table = "#####(replace) tflocks table name. ${var.project_name}-terraform-locks#####"
    dynamodb_table = "ckltftest-terraform-locks"
    key = "terraform.tfstate"
    #region = "#####(replace) aws region. ie: us-west-2#####"
    region = "us-west-1"
    encrypt = true
  }
}

module "network" {
  source = "./modules/network"
  region = var.region
  project_name = var.project_name
  environment = terraform.workspace
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
}

module "iam" {
  source = "./modules/iam"
  region = var.region
  project_name = var.project_name
  environment = terraform.workspace
  ecr_list = module.cluster.ecr_list
  app_bucket = module.files.app_bucket
}

module "database" {
  source = "./modules/database"
  region = var.region
  project_name = var.project_name
  environment = terraform.workspace
  vpc_id = module.network.vpc_id
  security_group = module.network.database_security_group_id
  subnet_1_id = module.network.private_subnet_1_id
  subnet_2_id = module.network.private_subnet_2_id
  availability_zone = var.availability_zone_1
  db_instance_type = var.db_instance_type
  db_storage_size = var.db_storage_size
  db_username = var.db_username
  db_password = var.db_password
}

module "files" {
  source = "./modules/files"
  project_name = var.project_name
  environment = terraform.workspace
}

module "cluster" {
  source = "./modules/cluster"
  region = var.region
  project_name = var.project_name
  environment = terraform.workspace
  vpc_id = module.network.vpc_id
  ecs_instance_profile_id = module.iam.ecs-instance-profile.id
  ecs_instance_role = module.iam.ecs-instance-profile
  ecs_service_role = module.iam.ecs-service-role
  instance_type = var.cluster_instance_type
  max_instances = var.cluster_max_instances
  min_instances = var.cluster_min_instances
  desired_instances = var.cluster_desired_instances
  private_security_group_id = module.network.private_security_group_id
  public_security_group_id = module.network.public_security_group_id
  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id
  public_subnet_1_id = module.network.public_subnet_1_id
  public_subnet_2_id = module.network.public_subnet_2_id
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  domains = var.domains
  app_bucket = module.files.app_bucket.bucket
  database = {
    username = module.database.db_username,
    password = module.database.db_password,
    hostname = module.database.db_hostname,
    name = module.database.db_name,
  }
  backend_secret_key = var.backend_secret_key
  backend_email_from = var.backend_email_from
  public_key = var.public_key
}
