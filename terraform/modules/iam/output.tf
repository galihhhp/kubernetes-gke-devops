output "cicd_service_account_email" {
  description = "Email of the CI/CD service account for GitHub Actions"
  value       = google_service_account.cicd_service_account.email
}

output "cicd_service_account_name" {
  description = "Name of the CI/CD service account"
  value       = google_service_account.cicd_service_account.name
}

output "cicd_service_account_id" {
  description = "ID of the CI/CD service account (account_id)"
  value       = google_service_account.cicd_service_account.account_id
}

output "workload_service_accounts" {
  description = "Map of workload service account details by component"
  value = {
    for component, sa in google_service_account.workload_service_accounts :
    component => {
      email      = sa.email
      name       = sa.name
      id         = sa.id
      account_id = sa.account_id
    }
  }
}

output "frontend_service_account_email" {
  description = "Email of the frontend service account"
  value       = try(google_service_account.workload_service_accounts["frontend"].email, null)
}

output "backend_service_account_email" {
  description = "Email of the backend service account"
  value       = try(google_service_account.workload_service_accounts["backend"].email, null)
}

output "database_service_account_email" {
  description = "Email of the database service account"
  value       = try(google_service_account.workload_service_accounts["database"].email, null)
}

output "monitoring_service_account_email" {
  description = "Email of the monitoring service account"
  value       = try(google_service_account.workload_service_accounts["monitoring"].email, null)
}

output "workload_identity_bindings" {
  description = "Map of workload identity bindings (only available when enable_workload_identity = true)"
  value = var.enable_workload_identity ? {
    for component, binding in google_service_account_iam_binding.workload_identity_bindings :
    component => {
      service_account_id = binding.service_account_id
      role               = binding.role
      members            = binding.members
    }
  } : {}
}

output "workload_identity_enabled" {
  description = "Whether workload identity bindings are enabled"
  value       = var.enable_workload_identity
}

output "gke_node_service_account_email" {
  description = "Email of the GKE node service account"
  value       = google_service_account.gke_node_service_account.email
}

output "gke_node_service_account_id" {
  description = "ID of the GKE node service account (account_id)"
  value       = google_service_account.gke_node_service_account.account_id
}
