############### VPC ##########################

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

############## Compute ##############################

variable "instance_type" {
  description = "Ec2 instance type"
  type        = map(string)
  default = {
    "dev"   = "t3.micro"
    "stage" = "t2.medium"
    "prod"  = "t2.large"
  }
}

############# DB #########################

variable "db_name" {
  description = "Name of DB"
  type        = string
}

variable "engine" {
  description = "DB Engine Name"
  type        = string
}

variable "engine_version" {
  description = "DB Engine Version"
  type        = string
}

variable "instance_class" {
  description = "Instance Class"
  type        = string
}

variable "username" {
  description = "Username of Database"
  type        = string
}

variable "password" {
  description = "Database Password"
  type        = string
}

variable "parameter_group_name" {
  description = "DB parameter group name"
  type        = string
}

variable "skip_final_snapshot" {
  description = "DB final snapshot"
  type        = bool
}

variable "region" {
  type = string
}