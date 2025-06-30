terraform {
  backend "gcs" {
    bucket = "tf-k8s-state"
    prefix = "terraform/k8s"
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = "${var.region}-a"
}

module "network" {
  source = "./modules/networking"

  region                   = var.region
  network_name             = var.network_name
  network_description      = var.network_description
  subnet_name              = var.subnet_name
  primary_range            = var.primary_range
  secondary_range_pods     = var.secondary_range_pods
  secondary_range_services = var.secondary_range_services
}
