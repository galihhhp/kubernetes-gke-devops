data "google_compute_network" "network" {
  name = var.network_name
}

data "google_compute_subnetwork" "subnet" {
  name   = var.subnet_name
  region = var.region
}

resource "google_container_cluster" "main" {
  name                     = var.cluster_name
  location                 = "${var.region}-a"
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
    enabled = false
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false # dont do this in prod
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = local.secondary_ranges.pods_name
    services_secondary_range_name = local.secondary_ranges.services_name
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.primary_range
      display_name = "cluster-subnet"
    }

    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "allow-all" # dont do this in prod
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

resource "google_container_node_pool" "app_node" {
  name               = "app-${var.node_pool_name}"
  location           = "${var.region}-a"
  cluster            = google_container_cluster.main.name
  initial_node_count = 1

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  node_config {
    preemptible     = var.preemptible
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size_gb
    tags            = [local.tags.gke_node, local.tags.app]
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      "workload" = "app"
    }

    taint {
      key    = "workload"
      value  = "app"
      effect = "NO_SCHEDULE"
    }
  }
}

resource "google_container_node_pool" "database_node" {
  name               = "database-${var.node_pool_name}"
  location           = "${var.region}-a"
  cluster            = google_container_cluster.main.name
  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    preemptible     = var.preemptible
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size_gb
    disk_type       = "pd-ssd"
    tags            = [local.tags.gke_node, local.tags.postgresql]
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      "workload" = "database"
    }

    taint {
      key    = "workload"
      value  = "database"
      effect = "PREFER_NO_SCHEDULE"
    }
  }
}

resource "google_container_node_pool" "general_node" {
  name               = "general-${var.node_pool_name}"
  location           = "${var.region}-a"
  cluster            = google_container_cluster.main.name
  initial_node_count = 1

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    preemptible     = var.preemptible
    machine_type    = var.machine_type
    disk_size_gb    = var.disk_size_gb
    tags            = [local.tags.gke_node]
    service_account = var.service_account_email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
    ]

    workload_metadata_config {
      mode = "GKE_METADATA"
    }

    labels = {
      "workload" = "general"
    }
  }
}
