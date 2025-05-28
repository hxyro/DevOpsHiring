variable "digitalocean_region" {
  description = "DigitalOcean region"
  type        = string
  default     = "blr1"
}

variable "digitalocean_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}