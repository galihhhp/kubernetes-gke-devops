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
