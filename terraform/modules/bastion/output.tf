output "name" {
  value       = var.name
  description = "Name of the bastion VM"
}

output "machine_type" {
  value       = var.machine_type
  description = "Machine type for the bastion VM"
}

output "zone" {
  value       = var.zone
  description = "Zone for the bastion VM"
}

output "image" {
  value       = var.image
  description = "Boot disk image for the bastion VM"
}

output "disk_size_gb" {
  value       = var.disk_size_gb
  description = "Boot disk size in GB for the bastion VM"
}

output "network" {
  value       = var.network
  description = "VPC network for the bastion VM"
}

output "subnetwork" {
  value       = var.subnetwork
  description = "Subnetwork for the bastion VM"
}

output "metadata" {
  value       = var.metadata
  description = "Metadata for the bastion VM"
}

output "internal_ip" {
  value       = google_compute_instance.bastion.network_interface[0].network_ip
  description = "Internal IP address of the bastion VM"
}

output "external_ip" {
  value       = google_compute_instance.bastion.network_interface[0].access_config[0].nat_ip
  description = "External IP address of the bastion VM"
}
