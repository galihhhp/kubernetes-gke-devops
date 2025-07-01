variable "bastion_name" {
  type        = string
  description = "Name of the bastion VM"
}

variable "bastion_machine_type" {
  type        = string
  description = "Machine type for the bastion VM"
}

variable "bastion_zone" {
  type        = string
  description = "Zone for the bastion VM"
}

variable "bastion_image" {
  type        = string
  description = "Boot disk image for the bastion VM"
}

variable "bastion_disk_size_gb" {
  type        = number
  description = "Boot disk size in GB for the bastion VM"
}

variable "bastion_metadata" {
  type        = map(string)
  description = "Metadata for the bastion VM"
  default     = {}
}

variable "iap_user" {
  type        = string
  description = "User email to grant IAP tunnel and OS Login access for bastion VM"
}
