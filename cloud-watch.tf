resource "aws_cloudwatch_log_group" "frontend_log_group" {
  name              = "/ecs/${var.project_name}-frontend"
  retention_in_days = 7 # Optional: Set log retention period
}

resource "aws_cloudwatch_log_group" "backend_log_group" {
  name              = "/ecs/${var.project_name}-backend"
  retention_in_days = 7 # Optional: Set log retention period
}
