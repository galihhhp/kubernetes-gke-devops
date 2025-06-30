output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.network.vpc_id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = module.network.vpc_name
}

output "vpc_self_link" {
  description = "The URI of the VPC"
  value       = module.network.vpc_self_link
}

output "subnet_id" {
  description = "The ID of the subnet"
  value       = module.network.subnet_id
}

output "subnet_name" {
  description = "The name of the subnet"
  value       = module.network.subnet_name
}

output "subnet_self_link" {
  description = "The URI of the subnet"
  value       = module.network.subnet_self_link
}

output "subnet_region" {
  description = "The region of the subnet"
  value       = module.network.subnet_region
}

output "subnet_cidr" {
  description = "The primary CIDR of the subnet"
  value       = module.network.subnet_cidr
}

output "pods_cidr" {
  description = "The secondary CIDR for pods"
  value       = module.network.pods_cidr
}

output "pods_range_name" {
  description = "The name of the secondary range for pods"
  value       = module.network.pods_range_name
}

output "services_cidr" {
  description = "The secondary CIDR for services"
  value       = module.network.services_cidr
}

output "services_range_name" {
  description = "The name of the secondary range for services"
  value       = module.network.services_range_name
}

output "firewall_tags" {
  description = "The tags used for firewall rules"
  value       = module.network.firewall_tags
}
