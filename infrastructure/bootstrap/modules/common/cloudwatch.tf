resource "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name              = "${var.application_name}-api-gw"
  retention_in_days = "0"
}
