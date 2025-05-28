output "registry_id" {
  description = "The ID of the created DigitalOcean Container Registry"
  value       = digitalocean_container_registry.container_registry.id
}

output "registry_endpoint" {
  description = "The endpoint of the DigitalOcean Container Registry"
  value       = digitalocean_container_registry.container_registry.endpoint
}

output "registry_name" {
  description = "The name of the DigitalOcean Container Registry"
  value       = digitalocean_container_registry.container_registry.name
}