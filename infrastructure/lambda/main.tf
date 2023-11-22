provider "aws" {
  region = var.region
}

module "lambda" {
  source           = "./modules/lambda"
  application_name = var.application_name
  region           = var.region
}