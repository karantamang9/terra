### Web Application Deployment using Terraform
This README provides instructions for deploying your web application on AWS using Terraform. Follow these steps to set up your environment:
Prerequisites

- AWS Account: Make sure you have an AWS account and access keys (Access Key ID and Secret Access Key) with the necessary permissions for EC2, S3, and CloudFront.
  
- Docker Image: I ensure the web application is packaged as a Docker image. (if haven’t already, create a Dockerfile for your application.)
  
- Terraform Installation: Install Terraform on my local machine and download it from the official website.
  ### Steps
- Clone the Repository: Clone this repository to local machine.
- Configure Environment Variables: Set the following environment variables in Docker container.
- Write Terraform Configuration: Create the following Terraform files in your project directory:
- main.tf: Define AWS resources (EC2 instance, S3 bucket, CloudFront distribution, etc.). Customize the configuration according to requirements.
- Initialize and Apply: Run the following commands to initialize your Terraform project and create the resources:
- <terraform init>
-< terraform apply>
- Access  Web Application: Once Terraform completes the deployment, I will get the public IP address of EC2 instance. Access web application using that IP address.
- Cleanup
Remember to destroy the resources when done:

- <terraform destroy>
  ### Terraforme script
  -<provider "aws" {
  region = "us-west-2"
}
---------------------------
variable "aws_region" {
  description = "us-east-1"
}
variable "aws_access_key_id" {
  description = "AKIA5FTZC4SQXHQ6RHVB"
}
variable "aws_secret_access_key" {
  description = "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"
}
variable "s3_june" {
  description = "s3_june"
}
variable "instance_type" {
  description = "EC2 instance"
  default     = "t2.micro"
}
variable "desired_capacity" {
  description = "Desired capacity for auto-scaling"
  default     = 1
}
variable "max_size" {
  description = "Maximum size for auto-scaling"
  default     = 3
}
variable "min_size" {
  description = "Minimum size for auto-scaling"
  default     = 1
}
-------------------------------------------------------------
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
---------------------------------------------------------------------
terraform init
terraform plane
terraform apply
-----------------------------------------------------------------------
terraform destroy
---------------------------------------------------------------------->
  
