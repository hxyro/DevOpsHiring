resource "digitalocean_kubernetes_cluster" "cluster" {
  name                              = var.cluster_name
  region                            = var.region
  version                           = var.cluster_version
  vpc_uuid                          = var.vpc_id
  destroy_all_associated_resources  = var.destroy_all_associated_resources
  registry_integration              = var.registry_integration

  node_pool {
    name       = var.node_pool_0.name
    size       = var.node_pool_0.size
    node_count = var.node_pool_0.count
  }
}