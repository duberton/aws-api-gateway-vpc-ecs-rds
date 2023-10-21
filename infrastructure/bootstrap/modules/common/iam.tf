resource "aws_iam_role" "execution_role" {
  name               = "execution_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "execution_role_policy_attachment" {
  role       = aws_iam_role.execution_role.name
  policy_arn = aws_iam_policy.execution_role_policy.arn
}


resource "aws_iam_policy" "execution_role_policy" {
  name   = "execution_role_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.execution_role_document.json
}

data "aws_iam_policy_document" "execution_role_document" {

  statement {
    resources = ["*"]

    actions = [
      "ecs:ExecuteCommand",
      "ssm:StartSession",
      "ecs:DescribeTasks"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "ecs:ListClusters",
      "ecs:ListContainerInstances",
      "ecs:DescribeContainerInstances"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "ecr:PutImage",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:ListImages",
      "ecr:PutImage",
      "ecr:BatchGetImage"
    ]
  }

  statement {
    resources = ["*"]
    effect    = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "secretsmanager:GetSecretValue"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "ssm:GetParameters"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "ecs:ExecuteCommand",
      "ssm:StartSession",
      "ecs:DescribeTasks"
    ]
  }

  statement {
    resources = ["*"]
    effect    = "Allow"

    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "firehose:PutRecordBatch",
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents"
    ]
  }
}


resource "aws_iam_role" "task_role" {
  name               = "task_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}


resource "aws_iam_role_policy_attachment" "task_role_policy_attachment" {
  role       = aws_iam_role.task_role.name
  policy_arn = aws_iam_policy.task_role_policy.arn
}


resource "aws_iam_policy" "task_role_policy" {
  name   = "task_role_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.task_assume_role.json
}

data "aws_iam_policy_document" "task_assume_role" {
  statement {
    resources = ["*"]

    actions = [
      "sqs:SendMessage",
      "sqs:GetQueueUrl",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "sns:Publish"
    ]
  }

  statement {
    resources = ["*"]

    actions = [
      "dynamodb:DeleteItem",
      "dynamodb:PutItem",
      "dynamodb:UpdateItem",
      "dynamodb:Query"
    ]
  }
}
