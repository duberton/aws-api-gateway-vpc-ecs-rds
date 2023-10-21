resource "aws_api_gateway_rest_api" "bands_rest_api_gateway" {
  name = "Bands AWS API Gateway"
  body = data.template_file.bands_openapi_file.rendered
}

resource "aws_api_gateway_deployment" "bands_rest_api_gateway_deployment" {
  rest_api_id = aws_api_gateway_rest_api.bands_rest_api_gateway.id

  triggers = {
    redeployment = sha1(file("${path.module}/api_gateway.tf"))
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
    format          = "{ \"requestId\": \"$context.requestId\", \"sourceIp\": \"$context.identity.sourceIp\" }"
  }
}

data "template_file" "bands_openapi_file" {
  template = templatefile("../../openapi/bands.yaml", {
    nlb_dns     = data.aws_lb.nlb.dns_name,
    vpc_link_id = aws_api_gateway_vpc_link.bands_rest_api_gateway_vpc_link.id
  })
}

resource "aws_api_gateway_vpc_link" "bands_rest_api_gateway_vpc_link" {
  name        = "${var.application_name}-vpc-link"
  target_arns = [data.aws_lb.nlb.arn]
}

data "aws_iam_policy_document" "bands_rest_api_gateway_allow_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions   = ["execute-api:Invoke"]
    resources = [aws_api_gateway_rest_api.bands_rest_api_gateway.execution_arn]

    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = ["${data.http.ip.response_body}/32"]
    }
  }
}


data "http" "ip" {
  url = "https://ifconfig.me/ip"
}

resource "aws_api_gateway_rest_api_policy" "bands_rest_api_gateway_policy" {
  rest_api_id = aws_api_gateway_rest_api.bands_rest_api_gateway.id
  policy      = data.aws_iam_policy_document.bands_rest_api_gateway_allow_policy_document.json
}