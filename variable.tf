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
