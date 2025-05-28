output "registry_url" {
  value = module.container_registry.registry_endpoint
}

output "kubeconfig" {
  value = module.cluster.kubeconfig
  sensitive = true
}