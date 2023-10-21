module "nlb" {
  source = "terraform-aws-modules/alb/aws"

  name = "ecs-nlb"

  load_balancer_type = "network"

  vpc_id          = data.aws_vpc.vpc.id
  subnets         = data.aws_subnets.private.ids
  security_groups = [data.aws_security_group.sg_nlb.id]

  internal = true

  target_groups = [
    {
      name_prefix          = "tg-"
      backend_protocol     = "TCP"
      backend_port         = 8080
      target_type          = "ip"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 40
        path                = "/actuator/health"
        port                = 8080
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 2
        matcher             = "200-299"
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      action_type        = "forward"
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  tags = {
    Name = "${var.application_name}-nlb"
  }

  target_group_tags = {
    Resource = "${var.application_name}-nlb-tg-http"
  }
}
