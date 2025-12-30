variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "WEB_subnet_cidr" {
  description = "cidr for WEB subnet"
  type        = string
}

variable "APP_subnet_cidr" {
  description = "cidr for APP subnet"
  type        = string
}

variable "DB_subnet_cidr" {
  description = "cidr for DB subnet"
  type        = string
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
}


