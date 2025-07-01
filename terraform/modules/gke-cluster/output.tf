output "cluster_id" {
  description = "The GKE cluster ID"
  value       = google_container_cluster.main.id
}

output "cluster_name" {
  description = "The GKE cluster name"
  value       = google_container_cluster.main.name
}

output "cluster_location" {
  description = "The location (region) of the GKE cluster"
  value       = google_container_cluster.main.location
}

output "cluster_endpoint" {
  description = "The IP address of the cluster master"
  value       = google_container_cluster.main.endpoint
  sensitive   = true
}

output "cluster_ca_certificate" {
  description = "The cluster ca certificate (base64 encoded)"
  value       = google_container_cluster.main.master_auth[0].cluster_ca_certificate
  sensitive   = true
}

output "cluster_master_version" {
  description = "The current master version"
  value       = google_container_cluster.main.master_version
}

output "cluster_min_master_version" {
  description = "The minimum version of the master"
  value       = google_container_cluster.main.min_master_version
}

output "cluster_self_link" {
  description = "The server-defined URL for the resource"
  value       = google_container_cluster.main.self_link
}

output "cluster_network" {
  description = "The name of the Google Compute Engine network to which the cluster is connected"
  value       = google_container_cluster.main.network
}

output "cluster_subnetwork" {
  description = "The name of the Google Compute Engine subnetwork to which the cluster is connected"
  value       = google_container_cluster.main.subnetwork
}

output "cluster_services_ipv4_cidr" {
  description = "The IP address range of the Kubernetes services"
  value       = google_container_cluster.main.services_ipv4_cidr
}

output "cluster_ipv4_cidr" {
  description = "The IP address range of the cluster pods"
  value       = google_container_cluster.main.cluster_ipv4_cidr
}

output "workload_identity_pool" {
  description = "The workload identity pool for the cluster"
  value       = google_container_cluster.main.workload_identity_config[0].workload_pool
}

output "master_authorized_networks" {
  description = "Networks that are authorized to access the cluster master"
  value       = google_container_cluster.main.master_authorized_networks_config[0].cidr_blocks
}

output "master_ipv4_cidr_block" {
  description = "The IP range in CIDR notation used for the hosted master network"
  value       = google_container_cluster.main.private_cluster_config[0].master_ipv4_cidr_block
}

output "main_node_pool_id" {
  description = "The ID of the main node pool"
  value       = google_container_node_pool.main_node.id
}

output "main_node_pool_name" {
  description = "The name of the main node pool"
  value       = google_container_node_pool.main_node.name
}

output "main_node_pool_instance_group_urls" {
  description = "List of instance group URLs which have been assigned to the main node pool"
  value       = google_container_node_pool.main_node.instance_group_urls
}

output "main_node_pool_machine_type" {
  description = "The machine type for the main node pool"
  value       = google_container_node_pool.main_node.node_config[0].machine_type
}

output "kubectl_config_command" {
  description = "Command to configure kubectl"
  value       = "gcloud container clusters get-credentials ${google_container_cluster.main.name} --region=${google_container_cluster.main.location} --project=${var.project_id}"
}

output "cluster_resource_labels" {
  description = "The GCP resource labels applied to the cluster"
  value       = google_container_cluster.main.resource_labels
}

output "node_pools" {
  description = "List of node pools in the cluster"
  value = {
    main = {
      name         = google_container_node_pool.main_node.name
      machine_type = google_container_node_pool.main_node.node_config[0].machine_type
      disk_size_gb = google_container_node_pool.main_node.node_config[0].disk_size_gb
      min_nodes    = google_container_node_pool.main_node.autoscaling[0].min_node_count
      max_nodes    = google_container_node_pool.main_node.autoscaling[0].max_node_count
      preemptible  = google_container_node_pool.main_node.node_config[0].preemptible
    }
  }
}
