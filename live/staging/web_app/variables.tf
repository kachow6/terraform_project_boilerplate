variable "instance_type" {
  description = "the instance type we want to securely pass to the module"
  type        = string
  sensitive   = true
}