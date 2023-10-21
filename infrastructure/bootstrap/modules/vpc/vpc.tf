module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = "10.99.0.0/24"

  azs             = ["${var.region}a", "${var.region}b", "${var.region}c"]
  public_subnets  = ["10.99.0.0/28", "10.99.0.16/28", "10.99.0.32/28"]
  private_subnets = ["10.99.0.48/28", "10.99.0.64/28", "10.99.0.80/28"]

  enable_nat_gateway  = true
  single_nat_gateway  = true
  private_subnet_tags = tomap({ "type" = "private" })
  public_subnet_tags  = tomap({ "type" = "public" })
}

