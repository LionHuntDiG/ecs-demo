data "aws_caller_identity" "current" {}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project_name}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project_name}-ecs-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "dynamodb_access_policy" {
  name = "${var.project_name}-dynamodb-access-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:DescribeTable",
          "dynamodb:Query",
          "dynamodb:Scan",
          "dynamodb:GetItem",
          "dynamodb:PutItem"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/MyNoSQLTable"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ecr_pull_policy" {
  name = "${var.project_name}-ecr-pull-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/${var.project_name}-frontend",
          "arn:aws:ecr:${var.region}:${data.aws_caller_identity.current.account_id}:repository/${var.project_name}-backend"
        ]
      },
      {
        Effect   = "Allow",
        Action   = "ecr:GetAuthorizationToken",
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "cloudwatch_logs_policy" {
  name = "${var.project_name}-cloudwatch-logs-policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect = "Allow"
        Resource = [
          "${aws_cloudwatch_log_group.frontend_log_group.arn}:*",
          "${aws_cloudwatch_log_group.backend_log_group.arn}:*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_dynamodb_policy" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.dynamodb_access_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecr_pull_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecr_pull_policy.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_policy.arn
}
