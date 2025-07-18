#!/bin/bash

SA_NAME="terraform-github-actions-prod"
PROJECT_ID=$(gcloud config get-value project)
SA_EMAIL="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"

gcloud iam service-accounts create "$SA_NAME" --display-name "Terraform CI/CD Prod Service Account"

roles=(
  roles/viewer
  roles/compute.networkAdmin
  roles/compute.instanceAdmin.v1
  roles/iam.serviceAccountUser
  roles/container.admin
  roles/iam.serviceAccountAdmin
  roles/iam.serviceAccountKeyAdmin
  roles/resourcemanager.projectIamAdmin
  roles/storage.admin
  roles/compute.securityAdmin
)

for role in "${roles[@]}"; do
  gcloud projects add-iam-policy-binding "$PROJECT_ID" \
    --member="serviceAccount:$SA_EMAIL" \
    --role="$role"
done

gcloud storage buckets add-iam-policy-binding gs://tf-k8s-state-production \
  --member="serviceAccount:$SA_EMAIL" \
  --role="roles/storage.admin"

gcloud iam service-accounts keys create terraform-ci-prod-key.json \
  --iam-account="$SA_EMAIL"
