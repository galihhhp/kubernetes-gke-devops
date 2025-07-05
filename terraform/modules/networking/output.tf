output "vpc_id" {
  description = "The ID of the VPC"
  value       = google_compute_network.vpc_network.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc_network.name
}

output "vpc_self_link" {
  description = "The URI of the VPC"
  value       = google_compute_network.vpc_network.self_link
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = google_compute_subnetwork.subnet.id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = google_compute_subnetwork.subnet.name
}

output "subnet_self_link" {
  description = "The URI of the subnet"
  value       = google_compute_subnetwork.subnet.self_link
}

output "subnet_region" {
  description = "The region of the subnet"
  value       = google_compute_subnetwork.subnet.region
}

output "subnet_cidr" {
  description = "The primary CIDR of the subnet"
  value       = google_compute_subnetwork.subnet.ip_cidr_range
}

output "pods_cidr" {
  description = "The secondary CIDR for pods"
  value       = var.secondary_range_pods
}

output "pods_range_name" {
  description = "The name of the secondary range for pods"
  value       = local.secondary_ranges.pods_name
}

output "services_cidr" {
  description = "The secondary CIDR for services"
  value       = var.secondary_range_services
}

output "services_range_name" {
  description = "The name of the secondary range for services"
  value       = local.secondary_ranges.services_name
}

output "firewall_tags" {
  description = "The tags used for firewall rules"
  value = {
    frontend   = "frontend"
    backend    = "backend"
    postgresql = "postgresql"
    gke_node   = "gke-node"
    monitoring = "monitoring"
  }
}
