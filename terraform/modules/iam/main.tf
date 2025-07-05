locals {
  service_account_roles = merge([
    for component, binding in var.workload_identity_bindings : {
      for role in binding.roles :
      "${component}-${role}" => {
        component = component
        role      = role
      }
    }
  ]...)
}

resource "google_service_account" "workload_service_accounts" {
  for_each = var.workload_identity_bindings

  account_id   = each.value.gcp_service_account_name
  display_name = "${title(each.key)} Service Account for ${var.environment}"
  description  = "Service account for ${each.key} component in ${var.environment} environment"
}

resource "google_project_iam_member" "workload_service_account_roles" {
  for_each = local.service_account_roles

  project = var.project_id
  role    = each.value.role
  member  = "serviceAccount:${google_service_account.workload_service_accounts[each.value.component].email}"
}

resource "google_service_account_iam_binding" "workload_identity_bindings" {
  for_each = var.enable_workload_identity ? var.workload_identity_bindings : {}

  service_account_id = google_service_account.workload_service_accounts[each.key].name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[${each.value.k8s_namespace}/${each.value.k8s_service_account_name}]"
  ]
}

resource "google_service_account" "cicd_service_account" {
  account_id   = "${var.environment}-cicd-sa"
  display_name = "CI/CD Service Account for ${var.environment}"
  description  = "Service account for CI/CD operations in ${var.environment} environment"
}

resource "google_project_iam_member" "cicd_service_account_roles" {
  for_each = toset([
    "roles/container.developer",
    "roles/storage.admin",
    "roles/container.admin",
    "roles/secretmanager.secretAccessor",
    "roles/monitoring.metricWriter"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.cicd_service_account.email}"
}

resource "google_service_account" "gke_node_service_account" {
  account_id   = "${var.environment}-gke-node-sa"
  display_name = "GKE Node Service Account for ${var.environment}"
  description  = "Service account for GKE nodes in ${var.environment} environment"
}

resource "google_project_iam_member" "gke_node_service_account_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/container.nodeServiceAccount"
  ])

  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_node_service_account.email}"
}


