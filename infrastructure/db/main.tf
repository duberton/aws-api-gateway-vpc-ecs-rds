provider "aws" {
  region = var.region
}

module "db" {
  source   = "./modules/db"
  vpc_name = "${var.application_name}-vpc"
}
