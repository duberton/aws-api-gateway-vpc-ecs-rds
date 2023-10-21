module "sg_lb" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.application_name}-sg-nlb"
  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "http"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "10.99.0.48/28"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "10.99.0.64/28"
    },
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = "10.99.0.80/28"
    }
  ]

  tags = {
    name = "sg-nlb"
  }
}

module "sg_ecs" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.application_name}-sg-ecs"
  vpc_id = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      protocol                 = "tcp"
      from_port                = 8080
      to_port                  = 8080
      source_security_group_id = module.sg_lb.security_group_id
    }
  ]

  # egress_rules = ["all-all"]

  egress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = "10.99.0.48/28"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = "10.99.0.64/28"
    },
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = "10.99.0.80/28"
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    }
  ]


  tags = {
    name = "sg-ecs"
  }
}

module "sg_db" {
  source = "terraform-aws-modules/security-group/aws"

  name   = "${var.application_name}-sg-db"
  vpc_id = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      protocol                 = "tcp"
      from_port                = 5432
      to_port                  = 5432
      source_security_group_id = module.sg_ecs.security_group_id
    }
  ]
  egress_rules = ["all-all"]

  tags = {
    name = "sg-db"
  }
}
