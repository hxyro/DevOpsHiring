resource "digitalocean_container_registry" "container_registry" {
  name                   = var.registry_name
  subscription_tier_slug = var.registry_subscription_tier_slug
  region                 = var.region
}