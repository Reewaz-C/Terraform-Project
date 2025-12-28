variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "WEB_subnet_cidr" {
  description = "cidr for WEB subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "APP_subnet_cidr" {
  description = "cidr for APP subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "DB_subnet_cidr" {
  description = "cidr for DB subnet"
  type        = string
  default     = "10.0.0.0/16"
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


