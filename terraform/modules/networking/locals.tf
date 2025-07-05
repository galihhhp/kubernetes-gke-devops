locals {
  tags = {
    gke_node   = "gke-node"
    app        = "app"
    postgresql = "postgresql"
    monitoring = "monitoring"
  }
  secondary_ranges = {
    pods_name     = "${var.subnet_name}-pods"
    services_name = "${var.subnet_name}-services"
  }
}
