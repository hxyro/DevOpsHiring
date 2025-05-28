terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
    }
    helm = {
      source = "hashicorp/helm"
      version = "3.0.0-pre2"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.37.1"
    }
  }
}

provider "kubernetes" {
    host                   = var.host
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    token                  = var.cluster_token
}


provider "helm" {
    kubernetes = {
        host                   = var.host
        cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
        token                  = var.cluster_token
    }
}