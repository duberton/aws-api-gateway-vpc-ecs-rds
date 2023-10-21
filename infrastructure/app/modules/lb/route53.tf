# resource "aws_route53_zone" "route53_zone" {
#   name = "${var.application_name}"
#   vpc {
#     vpc_id = data.aws_vpc.vpc.id
#   }
# }

# resource "aws_route53_record" "route53_record" {
#   zone_id = aws_route53_zone.route53_zone.id
#   name = "${var.application_name}.com"
#   type = "A"

#     alias {
#       name = module.nlb.lb_dns_name
#       zone_id = module.nlb.lb_zone_id
#       evaluate_target_health = false
#     }
# }
