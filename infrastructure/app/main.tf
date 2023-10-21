provider "aws" {
  region = var.region
}

module "lb" {
  source           = "./modules/lb"
  application_name = var.application_name
  region           = var.region
  vpc_name         = "${var.application_name}-vpc"
}

module "ecs" {
  source           = "./modules/ecs"
  application_name = var.application_name
  vpc_name         = "${var.application_name}-vpc"
  depends_on       = [module.lb]
}