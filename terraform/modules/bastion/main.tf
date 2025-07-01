resource "google_compute_instance" "bastion" {
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size_gb
    }
  }

  network_interface {
    network    = var.network
    subnetwork = var.subnetwork
    access_config {}
  }

  tags = ["bastion"]

  metadata = merge(
    var.metadata,
    {
      enable-oslogin = "TRUE",
      startup-script = file("${path.module}/bastion_startup.sh")
    }
  )
}
