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
