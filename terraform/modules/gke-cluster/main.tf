data "google_compute_network" "network" {
  name = var.network_name
}

data "google_compute_subnetwork" "subnet" {
  name   = var.subnet_name
  region = var.region
}

resource "google_container_cluster" "main" {
  name                     = var.cluster_name
  location                 = var.region
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = data.google_compute_network.network.self_link
  subnetwork               = data.google_compute_subnetwork.subnet.self_link
  deletion_protection      = var.deletion_protection
  logging_service          = "logging.googleapis.com/kubernetes"
  monitoring_service       = "monitoring.googleapis.com/kubernetes"
  enable_shielded_nodes    = true

  network_policy {
    enabled = true
  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 2
      maximum       = 10
    }

    resource_limits {
      resource_type = "memory"
      minimum       = 4
      maximum       = 20
    }
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = var.pods_range_name
    services_secondary_range_name = var.services_range_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.primary_range
      display_name = "cluster-subnet"
    }

    cidr_blocks {
      cidr_block   = var.admin_ip_cidr
      display_name = "${var.environment}-vm"
    }
  }

  maintenance_policy {
    recurring_window {
      start_time = "2023-01-01T17:00:00Z"
      end_time   = "2023-01-01T23:00:00Z"
      recurrence = "FREQ=WEEKLY;BYDAY=SU,WE"
    }
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  resource_labels = {
    environment = var.environment
  }
}

resource "google_container_node_pool" "main_node" {
  name     = var.node_pool_name
  location = var.region
  cluster  = google_container_cluster.main.name
  
  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible     = var.preemptible
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size_gb
    tags            = [var.tag_gke_node, var.tag_frontend, var.tag_backend, var.tag_monitoring, var.tag_postgresql]
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      "node-type" = "standard"
      "workload"  = "application"
    }
  }
}

