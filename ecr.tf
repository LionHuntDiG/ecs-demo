resource "aws_ecr_repository" "frontend" {
  name = "${var.project_name}-frontend"
}

resource "aws_ecr_repository" "backend" {
  name = "${var.project_name}-backend"
}

resource "aws_ecr_repository" "database" {
  name = "${var.project_name}-database"
}

output "frontend_ecr_repository_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "backend_ecr_repository_url" {
  value = aws_ecr_repository.backend.repository_url
}

output "database_ecr_repository_url" {
  value = aws_ecr_repository.database.repository_url
}
