provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "ecs-demo-s3-state-2024"
    key    = "terraform-state"
    region = "us-east-1"
  }
}
