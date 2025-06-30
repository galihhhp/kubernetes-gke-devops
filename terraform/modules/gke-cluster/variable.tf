variable "region" {
  description = "The GCP region where resources will be deployed"
  type        = string
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

variable "machine_type" {
  description = "The machine type to use for GKE nodes"
  type        = string
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

variable "primary_range" {
  description = "The primary IP CIDR range for the subnet"
  type        = string
}

variable "network_name" {
  description = "Name of existing VPC network"
  type        = string
}

variable "subnet_name" {
  description = "Name of existing subnet"
  type        = string
}

variable "service_account_email" {
  description = "Email of the service account for GKE nodes"
  type        = string
}

variable "tag_gke_node" {
  description = "Tag for GKE nodes"
  type        = string
  default     = "gke-node"
}

variable "tag_frontend" {
  description = "Tag for frontend workloads"
  type        = string
  default     = "frontend"
}

variable "tag_backend" {
  description = "Tag for backend workloads"
  type        = string
  default     = "backend"
}

variable "tag_postgresql" {
  description = "Tag for PostgreSQL database workloads"
  type        = string
  default     = "postgresql"
}

variable "tag_monitoring" {
  description = "Tag for monitoring workloads"
  type        = string
  default     = "monitoring"
}

variable "pods_range_name" {
  description = "The name of the secondary range for pods"
  type        = string
}

variable "services_range_name" {
  description = "The name of the secondary range for services"
  type        = string
}

variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "admin_ip_cidr" {
  description = "Admin IP CIDR for master authorized networks"
  type        = string
}
