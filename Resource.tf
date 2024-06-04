resource "aws_s3_june" "webapp_bucket" {
  bucket = var.s3_june
  acl    = "private"
}
resource "aws_instance" "webapp_instance" {
  ami           = "ami-04b70fa74e45c3917"
  instance_type = var.t2.micro

  tags = {
    Name = "webapp-instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              docker run -d \
                -e AWS_ACCESS_KEY_ID=AKIA5FTZC4SQXHQ6RHVB \
                -e AWS_SECRET_ACCESS_KEY=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 \
                -e S3_BUCKET_NAME=s3_june \
                -e AWS_REGION=us-east-1 \
                -p 80:80 \
                ubuntu
              EOF
}
resource "aws_launch_configuration" "webapp_launch_config" {
  image_id        = "ami-04b70fa74e45c3917"
  instance_type   = var.us-east-1
   user_data = <<-EOF
              #!/bin/bash
              docker run -d \
                -e AWS_ACCESS_KEY_ID=AKIA5FTZC4SQXHQ6RHVB \
                -e AWS_SECRET_ACCESS_KEY=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 \
                -e S3_BUCKET_NAME=s3_june \
                -e AWS_REGION=us-east-1 \
                -p 80:80 \
                ubuntu
              EOF

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "webapp_autoscaling_group" {
  launch_configuration = aws_launch_configuration.webapp_launch_config.name
  min_size             = var.1
  max_size             = var.2
  desired_capacity     = var.1

  vpc_zone_identifier = [subnet-0f825a022079856ac]
}
resource "aws_cloudfront_distribution" "webapp_cdn" {
  origin {
    domain_name = aws_s3_bucket.webapp_bucket.website_endpoint
    origin_id   = "S3Origin"
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  default_root_object = "index.html"

  enabled = true

  tags = {
    Environment = "Production"
  }
}
