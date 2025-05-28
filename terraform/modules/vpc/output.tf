output "vpc_id" {
  description = "The ID of the created VPC"
  value       = digitalocean_vpc.vpc.id
}