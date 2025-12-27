variable "region" {
  description = "Aws region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Ec2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.medium", "t2.large"], var.instance_type)
    error_message = "Instance must be t3.micro, t2.mediumor t2.large."
  }
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "cidr for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
  default     = "us-east-1a"

  validation {
    condition     = contains(["us-east-1a", "us-east-1b", "us-east-1c"], var.availability_zone)
    error_message = "Availability ZOnes must be us-east-1a, us-east-1b or us-east-1c "
  }
}

variable "public_route" {
  description = "public route for public subnet"
  type        = string
  default     = "0.0.0.0/0"
}


variable "log_bucket_name" {
  type = string
}

variable "main_bucket_name" {
  type = string
}
