resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = var.network_description
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.primary_range
  region        = var.region
  network       = google_compute_network.vpc_network.id

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = var.secondary_range_pods
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = var.secondary_range_services
  }

  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_30_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_router" "router" {
  name    = "${var.network_name}-router"
  region  = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_address" "nat_ip" {
  name   = "${var.network_name}-nat-ip"
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name   = "${var.network_name}-nat"
  router = google_compute_router.router.name
  region = google_compute_router.router.region

  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.nat_ip.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ALL"
  }
}

resource "google_compute_firewall" "load_balancer" {
  name    = "allow-lb-to-frontend"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["3000"]
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16"
  ]
  target_tags = [var.tag_frontend]

  direction = "INGRESS"
  priority  = 1000

  description = "Allow traffic from load balancer to frontend"
}

resource "google_compute_firewall" "frontend_to_backend" {
  name    = "allow-frontend-to-backend"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["5173"]
  }

  source_tags = [var.tag_frontend]
  target_tags = [var.tag_backend]

  direction = "INGRESS"
  priority  = 1000

  description = "Allow traffic from frontend to backend"
}

resource "google_compute_firewall" "backend_to_db" {
  name    = "allow-backend-to-db"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_tags = [var.tag_backend]
  target_tags = [var.tag_postgresql]

  direction = "INGRESS"
  priority  = 1000

  description = "Allow traffic from backend to PostgreSQL"
}

resource "google_compute_firewall" "monitoring" {
  name    = "allow-monitoring"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["9090", "9091"]
  }

  source_tags = [var.tag_monitoring]
  target_tags = [var.tag_gke_node]

  direction = "INGRESS"
  priority  = 1000

  description = "Allow monitoring traffic"
}

resource "google_compute_firewall" "health_checks" {
  name    = "allow-health-checks"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "10256"]
  }


  source_ranges = [
    "35.191.0.0/16",
    "130.211.0.0/22"
  ]

  target_tags = [var.tag_gke_node]

  direction = "INGRESS"
  priority  = 1000

  description = "Allow GCP health checks"
}

resource "google_compute_firewall" "internal_communication" {
  name    = "allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  allow {
    protocol = "icmp"
  }


  source_ranges = [var.primary_range]


  target_tags = [var.tag_gke_node]

  direction = "INGRESS"
  priority  = 1000

  description = "Allow internal communication"
}

resource "google_compute_firewall" "deny_public_db" {
  name    = "deny-public-to-db"
  network = google_compute_network.vpc_network.name

  deny {
    protocol = "tcp"
    ports    = ["5432"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.tag_postgresql]

  direction = "INGRESS"
  priority  = 900

  description = "Deny public access to PostgreSQL"
}

resource "google_compute_firewall" "deny_public_backend" {
  name    = "deny-public-to-backend"
  network = google_compute_network.vpc_network.name

  deny {
    protocol = "tcp"
    ports    = ["5173"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.tag_backend]

  direction = "INGRESS"
  priority  = 900

  description = "Deny public access to backend"
}
