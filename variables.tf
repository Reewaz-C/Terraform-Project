variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR of VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR of subnet"
}

variable "az" {
  type        = string
  description = "Availability Zone"
}
variable "instance_type" {
  description = "Ec2 instance type"
  type        = map(string)
  default = {
    "dev" = "t3.micro"
    "stage" = "t2.medium"
    "prod" = "t2.large"
  }
}

variable "log_bucket_name" {
  type        = string
  description = "Log Bucket Name"
}

variable "main_bucket_name" {
  type        = string
  description = "Main Bucket Name"
}