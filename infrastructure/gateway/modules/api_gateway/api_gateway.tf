resource "aws_api_gateway_rest_api" "bands_rest_api_gateway" {
  name = "Bands AWS API Gateway"
  body = data.template_file.bands_openapi_file.rendered
}

resource "aws_api_gateway_deployment" "bands_rest_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.bands_rest_api_gateway.id

  triggers = {
    redeployment = sha1(file("../../openapi/bands.yaml"))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "bands_rest_api_gateway_stage" {
  deployment_id = aws_api_gateway_deployment.bands_rest_api_gateway_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.bands_rest_api_gateway.id
  stage_name    = "default"

  access_log_settings {
    destination_arn = data.aws_cloudwatch_log_group.api_gateway_log_group.arn
    format          = "{ \"requestId\": \"$context.requestId\", \"sourceIp\": \"$context.identity.sourceIp\", \"error_message\": \"$context.error.message\", \"error_response_type\": \"$context.error.responseType\" }"
  }
}

data "template_file" "bands_openapi_file" {
  template = templatefile("../../openapi/bands.yaml", {
    nlb_dns     = data.aws_lb.nlb.dns_name,
    vpc_link_id = aws_api_gateway_vpc_link.bands_rest_api_gateway_vpc_link.id,
    lambda_events_arn = data.aws_lambda_function.lambda_band_events.invoke_arn,
    api_gateway_role_arn = data.aws_iam_role.api_gateway_role.arn
  })
}

resource "aws_api_gateway_vpc_link" "bands_rest_api_gateway_vpc_link" {
  name        = "${var.application_name}-vpc-link"
  target_arns = [data.aws_lb.nlb.arn]
}