provider "aws" {
  region = var.region
}

module "common" {
  source           = "./modules/common"
  application_name = var.application_name
}

module "vpc" {
  source           = "./modules/vpc"
  application_name = var.application_name
  region           = var.region
  vpc_name         = "${var.application_name}-vpc"
  depends_on       = [module.common]
}