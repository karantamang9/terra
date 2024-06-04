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
  -terraform init
  -terraform apply
