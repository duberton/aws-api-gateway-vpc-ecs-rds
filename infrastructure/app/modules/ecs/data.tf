data "aws_ecr_repository" "ecr" {
  name = "${var.application_name}-ecr"
}

data "aws_lb_target_group" "tg" {
  tags = {
    Resource = "${var.application_name}-nlb-tg-http"
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  tags = {
    type = "private"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  tags = {
    type = "public"
  }
}

data "aws_security_group" "sg_ecs" {
  tags = {
    name = "sg-ecs"
  }
}

data "aws_iam_role" "execution_role" {
  name = "execution_role"
}

data "aws_iam_role" "task_role" {
  name = "task_role"
}

data "aws_secretsmanager_secret" "db_secrets" {
  name = "db_secrets"
}

data "aws_secretsmanager_secret_version" "db_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.db_secrets.id
}

data "aws_secretsmanager_secret" "dd_api_key" {
  name = "dd_api_key"
}

data "aws_secretsmanager_secret_version" "dd_api_key_version" {
  secret_id = data.aws_secretsmanager_secret.dd_api_key.id
}

data "aws_db_instance" "db" {
  db_instance_identifier = "bands-postgres-14"
}