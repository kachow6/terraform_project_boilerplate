variable "aws_region" {
  description = "the aws region to deploy our resources"
  type        = string
}

variable "stage" {
  description = "the stage name to deploy our resources"
  type        = string
}

variable "instance_type" {
  description = "the instance type for our ec2"
  type        = string
  sensitive   = true

  validation {
    condition     = contains(["t3.nano", "t3.micro"], var.instance_type)
    error_message = "Allowed values for instance_type are [\"t3.nano\", \"t3.micro\"]."
  }
}
