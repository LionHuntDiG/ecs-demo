resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.project_name}-alb-logs"
}

resource "aws_s3_bucket_policy" "alb_logs_policy" {
  bucket = aws_s3_bucket.alb_logs.bucket

  policy = jsonencode({
    Version: "2012-10-17",
    Statement: [
      {
        Effect: "Allow",
        Principal: {
          Service: "elasticloadbalancing.amazonaws.com"
        },
        Action: "s3:*",
        Resource: "*"
      }
    ]
  })
}

