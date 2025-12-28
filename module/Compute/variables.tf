variable "instance_type" {
  description = "Ec2 instance type"
  type        = string
  default     = "t3.micro"

  validation {
    condition     = contains(["t3.micro", "t2.medium", "t2.large"], var.instance_type)
    error_message = "Instance must be t3.micro, t2.mediumor t2.large."
  }
}
