resource "aws_db_subnet_group" "db_subnet" {
  name = "${var.project_name}-${var.environment}-db-subnet"
  subnet_ids = [var.subnet_1_id, var.subnet_2_id]
}

resource "aws_db_instance" "app_db" {
  instance_class = var.db_instance_type
  name = replace("${var.project_name}_${var.environment}", "-", "_")
  engine = "postgres"
  availability_zone = "${var.region}${var.availability_zone}"
  vpc_security_group_ids = [var.security_group]
  allocated_storage = var.db_storage_size
  password = var.db_password
  username = var.db_username
  identifier = "${var.project_name}-${var.environment}"
  db_subnet_group_name = aws_db_subnet_group.db_subnet.id
  final_snapshot_identifier = replace("${var.project_name}-${var.environment}-final-snapshot", "_", "-")

  tags = {
    "ckl:environment" = var.environment
    "ckl:project" = var.project_name
    "ckl:alias" = "app"
  }
}
