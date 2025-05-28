output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.cluster.kube_config
  description = "The kubeconfig for the DigitalOcean Kubernetes cluster"
  sensitive = true
}

output "cluster_id" {
  value       = digitalocean_kubernetes_cluster.cluster.id
  description = "The ID of the created DigitalOcean Kubernetes cluster"
}