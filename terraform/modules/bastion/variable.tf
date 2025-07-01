variable "name" {
  type        = string
  description = "Name of the bastion VM"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the bastion VM"
}

variable "zone" {
  type        = string
  description = "Zone for the bastion VM"
}

variable "image" {
  type        = string
  description = "Boot disk image for the bastion VM"
}

variable "disk_size_gb" {
  type        = number
  description = "Boot disk size in GB for the bastion VM"
}

variable "network" {
  type        = string
  description = "VPC network for the bastion VM"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork for the bastion VM"
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "Metadata for the bastion VM"
}
