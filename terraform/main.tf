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

module "iam" {
  source = "./modules/iam"

  project_id                 = var.project_id
  environment                = var.environment
  workload_identity_bindings = var.workload_identity_bindings
  # Workload Identity Configuration
  # FALSE: Use during initial deployment when GKE cluster doesn't exist yet
  # TRUE:  Use after GKE cluster is deployed
  enable_workload_identity = var.enable_workload_identity
  iap_user                 = var.iap_user
}

module "bastion" {
  source       = "./modules/bastion"
  name         = var.bastion_name
  machine_type = var.bastion_machine_type
  zone         = var.bastion_zone
  image        = var.bastion_image
  disk_size_gb = var.bastion_disk_size_gb
  network      = module.network.vpc_name
  subnetwork   = module.network.subnet_name
  metadata     = var.bastion_metadata
}

module "gke" {
  source = "./modules/gke-cluster"

  network_name          = module.network.vpc_name
  subnet_name           = module.network.subnet_name
  service_account_email = module.iam.gke_node_service_account_email
  pods_range_name       = module.network.pods_range_name
  services_range_name   = module.network.services_range_name
  deletion_protection   = var.deletion_protection
  disk_size_gb          = var.disk_size_gb
  region                = var.region
  preemptible           = var.preemptible
  min_node_count        = var.min_node_count
  max_node_count        = var.max_node_count
  primary_range         = var.primary_range
  node_pool_name        = var.node_pool_name
  cluster_name          = var.cluster_name
  machine_type          = var.machine_type
  environment           = var.environment
  project_id            = var.project_id
  bastion_internal_ip   = "${module.bastion.internal_ip}/32"
}
