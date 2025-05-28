variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
    default     = "default-cluster"
}

variable "region" {
  description = "Region for the DigitalOcean resources"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster"
  type        = string
  default     = "1.32.2-do.1"
}

variable "node_pool_0" {
    description = "Configuration for the node pool"
    type = object({
        name  = string
        size  = string
        count = number
    })
    default = {
        name  = "default"
        size  = "s-4vcpu-8gb"
        count = 1
    }
}

variable "vpc_id" {
  description = "ID of the VPC to use for the cluster"
  type        = string
}

variable "registry_integration" {
  description = "Enable integration with the Docker registry"
  type        = bool
  default     = true
}

variable "destroy_all_associated_resources" {
  description = "Destroy all resources associated with the cluster when it is deleted"
  type        = bool
  default     = true
}