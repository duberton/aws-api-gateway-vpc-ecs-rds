provider "aws" {
  region = var.region
}

module "db" {
  source   = "./modules/rds"
  vpc_name = "${var.application_name}-vpc"
}

module "dynamodb" {
  source   = "./modules/dynamodb"
  vpc_name = "${var.application_name}-vpc"
}
