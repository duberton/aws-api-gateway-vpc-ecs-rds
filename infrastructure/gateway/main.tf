provider "aws" {
  region = var.region
}

module "api_gateway" {
  source           = "./modules/api_gateway"
  application_name = var.application_name
  region           = var.region
}