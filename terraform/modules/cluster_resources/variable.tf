variable "host" {
  description = "The endpoint of the DigitalOcean Kubernetes cluster"
  type        = string
}

variable "cluster_ca_certificate" {
  description = "The CA certificate of the DigitalOcean Kubernetes cluster"
  type        = string
}

variable "cluster_token" {
  description = "The token for accessing the DigitalOcean Kubernetes cluster"
  type        = string
  sensitive   = true
}