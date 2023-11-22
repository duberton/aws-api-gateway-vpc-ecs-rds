locals {
  db_user     = jsondecode(data.aws_secretsmanager_secret_version.db_secrets_version.secret_string).user
  db_password = jsondecode(data.aws_secretsmanager_secret_version.db_secrets_version.secret_string).password
}

module "db" {
  source = "terraform-aws-modules/rds/aws"

  db_name    = "bands"
  identifier = "bands-postgres-14"

  username = local.db_user
  password = local.db_password

  engine                      = "postgres"
  engine_version              = "14"
  major_engine_version        = "14"
  family                      = "postgres14"
  instance_class              = "db.t3.micro"
  allocated_storage           = 5
  storage_encrypted           = false
  skip_final_snapshot         = true
  maintenance_window          = "Mon:00:00-Mon:03:00"
  backup_window               = "03:00-06:00"
  backup_retention_period     = 1
  deletion_protection         = false
  manage_master_user_password = false

  port                   = "5432"
  vpc_security_group_ids = [data.aws_security_group.sg_db.id]
  subnet_ids             = data.aws_subnets.private.ids

  create_db_instance        = true
  create_db_parameter_group = false
  create_db_subnet_group    = true
  create_db_option_group    = false

}
