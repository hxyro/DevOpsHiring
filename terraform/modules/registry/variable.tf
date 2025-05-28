variable "registry_name" {
  description = "Name of the Docker registry"
  type        = string
  default     = "hxyro-test"
}

variable "region" {
  description = "Region for the DigitalOcean resources"
  type        = string
}

variable "registry_subscription_tier_slug" {
  description = "Subscription tier for the Docker registry"
  type        = string
  default     = "starter"
}