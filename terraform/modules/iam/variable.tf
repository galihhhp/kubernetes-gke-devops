variable "project_id" {
  description = "The Google Cloud project ID"
  type        = string
}

variable "environment" {
  description = "Environment (dev, staging, prod)"
  type        = string
}

variable "workload_identity_bindings" {
  description = "Map of workload identity bindings for frontend, backend, database, and monitoring components"
  type = map(object({
    k8s_namespace            = string
    k8s_service_account_name = string
    gcp_service_account_name = string
    roles                    = list(string)
  }))
  default = {}
}

variable "enable_workload_identity" {
  description = "Enable workload identity bindings (set to false initially, true after GKE cluster exists)"
  type        = bool
  default     = false
}




