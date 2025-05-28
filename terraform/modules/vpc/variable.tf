variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "default-vpc"
}

variable "region" {
  description = "Region for the DigitalOcean resources"
  type        = string
}

variable "ip_range" {
  description = "IP range for the VPC in CIDR notation"
  type        = string
  default     = "10.0.0.0/16"
}