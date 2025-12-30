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

variable "vpc_security_group_ids" {
  description = "Security group of DB"
  type        = list(string)
}

variable "db_subnet_group_name" {
  description = "Database SUbnet"
  type        = string
}

variable "allocated_storage" {
  description = "DB allocated storage"
  type        = number
  default     = 10
}