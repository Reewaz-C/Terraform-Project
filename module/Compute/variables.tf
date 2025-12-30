variable "instance_type" {
  description = "Ec2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where EC2 instance will be launched"
  type        = string
}

variable "name" {
  description = "Name of Instance"
  type = string
}

variable "vpc_security_group_ids" {
  description = "SG Ids"
  type = list(string)
}