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

output "cicd_service_account_email" {
  description = "Email of the CI/CD service account for GitHub Actions"
  value       = module.iam.cicd_service_account_email
}

output "cicd_service_account_name" {
  description = "Name of the CI/CD service account"
  value       = module.iam.cicd_service_account_name
}

output "cicd_service_account_id" {
  description = "ID of the CI/CD service account (account_id)"
  value       = module.iam.cicd_service_account_id
}

output "workload_service_accounts" {
  description = "Map of workload service account details by component"
  value       = module.iam.workload_service_accounts
}

output "frontend_service_account_email" {
  description = "Email of the frontend service account"
  value       = module.iam.frontend_service_account_email
}

output "backend_service_account_email" {
  description = "Email of the backend service account"
  value       = module.iam.backend_service_account_email
}

output "database_service_account_email" {
  description = "Email of the database service account"
  value       = module.iam.database_service_account_email
}

output "monitoring_service_account_email" {
  description = "Email of the monitoring service account"
  value       = module.iam.monitoring_service_account_email
}

output "workload_identity_bindings" {
  description = "Map of workload identity bindings (only available when enable_workload_identity = true)"
  value       = module.iam.workload_identity_bindings
}

output "workload_identity_enabled" {
  description = "Whether workload identity bindings are enabled"
  value       = module.iam.workload_identity_enabled
}

output "gke_node_service_account_email" {
  description = "Email of the GKE node service account"
  value       = module.iam.gke_node_service_account_email
}

output "gke_node_service_account_id" {
  description = "ID of the GKE node service account (account_id)"
  value       = module.iam.gke_node_service_account_id
}

output "cluster_id" {
  description = "The GKE cluster ID"
  value       = module.gke.cluster_id
}

output "cluster_name" {
  description = "The GKE cluster name"
  value       = module.gke.cluster_name
}

output "cluster_location" {
  description = "The location (region) of the GKE cluster"
  value       = module.gke.cluster_location
}

output "cluster_endpoint" {
  description = "The IP address of the cluster master"
  value       = module.gke.cluster_endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The cluster ca certificate (base64 encoded)"
  value       = module.gke.cluster_ca_certificate
  sensitive   = true
}

output "cluster_master_version" {
  description = "The current master version"
  value       = module.gke.cluster_master_version
}

output "cluster_min_master_version" {
  description = "The minimum version of the master"
  value       = module.gke.cluster_min_master_version
}

output "cluster_self_link" {
  description = "The server-defined URL for the resource"
  value       = module.gke.cluster_self_link
}

output "cluster_network" {
  description = "The name of the Google Compute Engine network to which the cluster is connected"
  value       = module.gke.cluster_network
}

output "cluster_subnetwork" {
  description = "The name of the Google Compute Engine subnetwork to which the cluster is connected"
  value       = module.gke.cluster_subnetwork
}

output "cluster_services_ipv4_cidr" {
  description = "The IP address range of the Kubernetes services"
  value       = module.gke.cluster_services_ipv4_cidr
}

output "cluster_ipv4_cidr" {
  description = "The IP address range of the cluster pods"
  value       = module.gke.cluster_ipv4_cidr
}

output "workload_identity_pool" {
  description = "The workload identity pool for the cluster"
  value       = module.gke.workload_identity_pool
}

output "master_authorized_networks" {
  description = "Networks that are authorized to access the cluster master"
  value       = module.gke.master_authorized_networks
}

output "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation used for the hosted master network"
  value       = module.gke.master_ipv4_cidr_block
}

output "main_node_pool_id" {
  description = "The ID of the main node pool"
  value       = module.gke.main_node_pool_id
}

output "main_node_pool_name" {
  description = "The name of the main node pool"
  value       = module.gke.main_node_pool_name
}

output "main_node_pool_instance_group_urls" {
  description = "List of instance group URLs which have been assigned to the main node pool"
  value       = module.gke.main_node_pool_instance_group_urls
}

output "main_node_pool_machine_type" {
  description = "The machine type for the main node pool"
  value       = module.gke.main_node_pool_machine_type
}

output "kubectl_config_command" {
  description = "Command to configure kubectl"
  value       = module.gke.kubectl_config_command
}

output "cluster_resource_labels" {
  description = "The GCP resource labels applied to the cluster"
  value       = module.gke.cluster_resource_labels
}

output "node_pools" {
  description = "List of node pools in the cluster"
  value       = module.gke.node_pools
}

output "connection_info" {
  description = "Information needed to connect to the GKE cluster"
  value = {
    cluster_name     = module.gke.cluster_name
    cluster_location = module.gke.cluster_location
    kubectl_command  = module.gke.kubectl_config_command
    endpoint         = module.gke.cluster_endpoint
  }
  sensitive = true
}

output "service_accounts_summary" {
  description = "Summary of all service accounts created"
  value = {
    cicd_sa       = module.iam.cicd_service_account_email
    gke_node_sa   = module.iam.gke_node_service_account_email
    frontend_sa   = module.iam.frontend_service_account_email
    backend_sa    = module.iam.backend_service_account_email
    database_sa   = module.iam.database_service_account_email
    monitoring_sa = module.iam.monitoring_service_account_email
  }
}

output "network_summary" {
  description = "Summary of network configuration"
  value = {
    vpc_name      = module.network.vpc_name
    subnet_name   = module.network.subnet_name
    subnet_cidr   = module.network.subnet_cidr
    pods_cidr     = module.network.pods_cidr
    services_cidr = module.network.services_cidr
    firewall_tags = module.network.firewall_tags
  }
}
