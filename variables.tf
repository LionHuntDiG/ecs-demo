variable "region" {
  default = "us-east-1"
}

variable "project_name" {
  default = "myapp"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "dynamodb_table_name" {
  default = "MyNoSQLTable"
}
variable "account" {
  description = "AWS account ID for the ECR repository"
  type        = string
  default = "462585606803"
}
