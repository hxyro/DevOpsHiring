module "vpc" {
  source = "./modules/vpc"
  region = var.digitalocean_region
}

module "container_registry" {
  source = "./modules/registry"
  region = var.digitalocean_region
}

module "cluster" {
  depends_on = [ module.vpc, module.container_registry ]
  source     = "./modules/cluster"
  region     = var.digitalocean_region
  vpc_id     = module.vpc.vpc_id
}

module "cluster_resources" {
  source = "./modules/cluster_resources"
  host = module.cluster.kubeconfig.0.host
  cluster_ca_certificate = module.cluster.kubeconfig.0.cluster_ca_certificate
  cluster_token = module.cluster.kubeconfig.0.token
}