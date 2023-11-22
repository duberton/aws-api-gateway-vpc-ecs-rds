module "lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "bands-events"
  handler       = "main.lambda_handler"
  runtime       = "python3.8"
  publish       = true

  source_path = "./bands-events"

  attach_tracing_policy    = true
  attach_policy_statements = true

  policy_statements = {
    lambda = {
      effect = "Allow",
      actions = [
        "lambda:InvokeFunction",
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "dynamodb:DeleteItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Query"
      ],
      resources = ["*"]
    }
  }

  allowed_triggers = {
    AllowExecutionFromAPIGateway = {
      service    = "apigateway"
      principal  = "apigateway.amazonaws.com"
      source_arn = "${data.aws_api_gateway_rest_api.bands_rest_api_gateway.execution_arn}/*/*"
    }
  }
}
