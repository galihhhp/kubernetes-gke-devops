variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "region" {
  description = "The GCP region where resources will be deployed"
  type        = string
}

variable "network_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "network_description" {
  description = "Description for the VPC network"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "primary_range" {
  description = "The primary IP CIDR range for the subnet"
  type        = string
}

variable "secondary_range_pods" {
  description = "The secondary IP CIDR range for GKE pods"
  type        = string
}

variable "secondary_range_services" {
  description = "The secondary IP CIDR range for GKE services"
  type        = string
}

variable "workload_identity_bindings" {
  description = "Map of workload identity bindings for frontend, backend, database, and monitoring components"
  type = map(object({
    k8s_namespace            = string
    k8s_service_account_name = string
    gcp_service_account_name = string
    roles                    = list(string)
  }))
  default = {}
}

variable "enable_workload_identity" {
  description = "Enable workload identity bindings (set to false initially, true after GKE cluster exists)"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "min_node_count" {
  description = "Minimum number of nodes in the GKE node pool for autoscaling"
  type        = number
  default     = 3
}

variable "max_node_count" {
  description = "Maximum number of nodes in the GKE node pool for autoscaling"
  type        = number
  default     = 10
}

variable "disk_size_gb" {
  description = "The size of the disk in GB for each GKE node"
  type        = number
}

variable "preemptible" {
  description = "Whether to use preemptible nodes for the GKE cluster"
  type        = bool
}

variable "node_pool_name" {
  description = "The name of the GKE node pool"
  type        = string
}

variable "deletion_protection" {
  description = "Whether deletion protection is enabled for the GKE cluster"
  type        = bool
}

variable "machine_type" {
  description = "The machine type to use for GKE nodes"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, prod)"
  type        = string
}


