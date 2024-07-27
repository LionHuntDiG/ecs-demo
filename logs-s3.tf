resource "aws_s3_bucket" "alb_logs" {
  bucket = "${var.project_name}-alb-logs"
}

resource "aws_s3_bucket_acl" "alb_logs_acl" {
  bucket = aws_s3_bucket.alb_logs.bucket
  acl    = "private"
}

resource "aws_s3_bucket_policy" "alb_logs_policy" {
  bucket = aws_s3_bucket.alb_logs.bucket

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AWSLogDeliveryWrite"
        Effect    = "Allow"
        Principal = {
          Service = "logdelivery.elasticloadbalancing.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${aws_s3_bucket.alb_logs.arn}/*"
      }
    ]
  })
}
