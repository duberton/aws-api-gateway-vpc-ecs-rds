data "aws_lb" "nlb" {
  tags = {
    Name = "${var.application_name}-nlb"
  }
}

data "aws_lambda_function" "lambda_band_events" {
  function_name = "bands-events"
}

data "aws_iam_role" "api_gateway_role" {
  name = "api-gateway-lambda-role"
}

data "aws_cloudwatch_log_group" "api_gateway_log_group" {
  name = "${var.application_name}-api-gw"
}