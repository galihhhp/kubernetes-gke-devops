# Kubernetes GKE DevOps

## Overview

This repository provides a comprehensive, hands-on journey to master Kubernetes on Google Kubernetes Engine (GKE). Building upon your existing knowledge of Docker, Terraform, Ansible, and GitHub Actions, this challenge series will take you from K8s fundamentals to advanced production-ready deployments.

## Table of Contents

- [Project Overview](#project-overview)
- [Prerequisites](#prerequisites)
- [Directory Structure](#directory-structure)
- [Challenges](#challenges)
  - [Challenge 1: K8s Foundations & GKE Cluster Setup](#challenge-1-k8s-foundations--gke-cluster-setup)
  - [Challenge 2: Application Deployment & Service Management](#challenge-2-application-deployment--service-management)
  - [Challenge 3: Configuration Management & Secrets](#challenge-3-configuration-management--secrets)
  - [Challenge 4: Storage & Persistent Data Management](#challenge-4-storage--persistent-data-management)
  - [Challenge 5: Service Mesh & Advanced Networking](#challenge-5-service-mesh--advanced-networking)
  - [Challenge 6: Monitoring, Logging & Observability](#challenge-6-monitoring-logging--observability)
  - [Challenge 7: Auto-scaling & Resource Management](#challenge-7-auto-scaling--resource-management)
  - [Challenge 8: Security & RBAC Implementation](#challenge-8-security--rbac-implementation)
  - [Challenge 9: Advanced CI/CD with GitHub Actions & K8s](#challenge-9-advanced-cicd-with-github-actions--k8s)
  - [Challenge 10: Multi-Environment & Blue-Green Deployments](#challenge-10-multi-environment--blue-green-deployments)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Project Overview

This project focuses on mastering Kubernetes using Google Kubernetes Engine (GKE) through practical, production-ready scenarios. You'll deploy a complete microservices application stack while learning advanced K8s concepts, best practices, and GCP-specific features.

## Prerequisites

- **Existing Knowledge:** Docker, Terraform, Ansible, GitHub Actions
- **Google Cloud Platform Account** with billing enabled
- **kubectl** installed and configured
- **Google Cloud SDK (gcloud)** installed
- **Basic understanding** of YAML and containerization
- **Recommended Setup:** Ubuntu 22.04 LTS or macOS for development environment

## Directory Structure

```
kubernetes-gke-devops/
├── README.md
├── .gitignore
├── terraform/
│   ├── environments/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   └── modules/
│       ├── gke-cluster/
│       ├── networking/
│       └── storage/
├── k8s/
│   ├── base/
│   │   ├── deployments/
│   │   ├── services/
│   │   ├── configmaps/
│   │   └── secrets/
│   ├── overlays/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   └── manifests/
│       ├── fastify-app/
│       ├── postgresql/
│       └── monitoring/

├── ansible/
│   ├── playbooks/
│   │   ├── setup-environment.yml
│   │   ├── deploy-application.yml
│   │   ├── backup-restore.yml
│   │   └── disaster-recovery.yml
│   ├── roles/
│   │   ├── gcp-tools/
│   │   ├── k8s-tools/
│   │   ├── monitoring/
│   │   └── security/
│   ├── inventory/
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   └── group_vars/
├── monitoring/
│   ├── prometheus/
│   ├── grafana/
│   └── alertmanager/
├── gitops/
│   ├── workflows/
│   └── deployment-configs/
└── .github/
    └── workflows/
```

## Challenges

### 🟢 Challenge 1: K8s Foundations & GKE Cluster Setup

**Level: BEGINNER** | **Prerequisites: Docker basics**

**Objective:** Master Kubernetes fundamentals and create your first production-ready GKE cluster using Terraform.

**What You'll Build:**

- **Terraform modules** for GKE cluster provisioning with:
  - Private cluster configuration
  - Node pools with different machine types
  - Network policies and firewall rules
  - IAM roles and service accounts
- **kubectl** configuration and cluster access setup
- **Basic pod, deployment, and service** creation
- **Namespace** organization and resource quotas
- **Ingress controller** setup (nginx-ingress or GKE Ingress)

**Skills Learned:**

- **GKE cluster architecture** and networking
- **Terraform for GCP** resource management
- **kubectl** command mastery
- **Kubernetes resource types** and relationships
- **GCP IAM** integration with Kubernetes
- **Cluster security** best practices

**Deliverables:**

- Terraform code for GKE cluster
- Ansible playbooks for kubectl configuration and cluster setup
- Automated application deployment via Ansible
- Network security configuration through Ansible roles
- Documentation of cluster setup process

---

### 🟢 Challenge 2: Application Deployment & Service Management

**Level: BEGINNER** | **Prerequisites: Challenge 1**

**Objective:** Deploy a multi-tier Fastify application with proper service discovery and load balancing.

**What You'll Build:**

- **Containerized Fastify application** with health checks
- **Multi-tier deployment** (frontend, backend, database)
- **Service discovery** between components
- **Load balancing** with different service types
- **Horizontal Pod Autoscaler (HPA)** configuration
- **Resource limits and requests** optimization
- **Liveness and readiness probes** implementation

**Skills Learned:**

- **Microservices deployment** patterns
- **Service mesh basics** (preparation for Istio)
- **Pod lifecycle management**
- **Resource optimization** techniques
- **Health check** implementation
- **Load balancing** strategies in K8s

**Deliverables:**

- Complete application manifests
- Service discovery configuration
- Auto-scaling policies
- Health check implementation
- Performance testing results

---

### 🟡 Challenge 3: Configuration Management & Secrets

**Level: INTERMEDIATE** | **Prerequisites: Challenge 2**

**Objective:** Implement secure and flexible configuration management using ConfigMaps, Secrets, and external secret management.

**What You'll Build:**

- **ConfigMaps** for application configuration
- **Kubernetes Secrets** for sensitive data
- **Google Secret Manager** integration
- **Kustomize** for environment-specific configurations
- **Init containers** for configuration setup
- **Volume mounts** for configuration files
- **Environment variable** injection patterns
- **Configuration hot-reloading** strategies

**Skills Learned:**

- **Secret management** best practices in K8s
- **Kustomize** for configuration templating (without Helm)
- **GCP Secret Manager** integration
- **Configuration injection** methods
- **Security hardening** for sensitive data
- **Environment separation** strategies

**Deliverables:**

- Kustomize overlays for different environments
- Secret management integration via Ansible
- Ansible playbooks for configuration validation
- Security audit documentation
- Automated hot-reload implementation

---

### 🟡 Challenge 4: Storage & Persistent Data Management

**Level: INTERMEDIATE** | **Prerequisites: Challenge 3**

**Objective:** Implement persistent storage solutions for stateful applications using GKE storage options.

**What You'll Build:**

- **Persistent Volumes (PV)** and **Persistent Volume Claims (PVC)**
- **StatefulSets** for PostgreSQL database deployment
- **PostgreSQL container** deployment with persistent storage
- **Cloud Storage** integration for database backups
- **Backup and restore** procedures for PostgreSQL data
- **Storage classes** configuration for different performance needs
- **Volume snapshots** for data protection

**Skills Learned:**

- **Stateful application** deployment patterns with PostgreSQL
- **Storage orchestration** in Kubernetes
- **Database containerization** best practices
- **Data persistence** strategies for databases
- **PostgreSQL backup automation** with cloud storage
- **Storage performance** optimization for databases

**Deliverables:**

- PostgreSQL StatefulSet configurations
- Storage class definitions for database storage
- Ansible playbooks for PostgreSQL backup automation
- Automated database migration procedures
- PostgreSQL monitoring setup via Ansible

---

### 🔴 Challenge 5: Service Mesh & Advanced Networking

**Level: EXPERT** | **Prerequisites: Challenge 4, Strong networking knowledge**

**Objective:** Implement advanced networking features and service mesh capabilities for microservices communication.

**What You'll Build:**

- **Istio service mesh** installation and configuration
- **Traffic management** policies (routing, load balancing)
- **Security policies** (mTLS, authorization)
- **Network policies** for pod-to-pod communication
- **Ingress Gateway** configuration
- **Circuit breaker** and **retry policies**
- **Canary deployments** using traffic splitting

**Skills Learned:**

- **Service mesh architecture** and benefits
- **Advanced networking** in Kubernetes
- **Security policies** implementation
- **Traffic management** strategies
- **Observability** through service mesh
- **Progressive delivery** techniques

**Deliverables:**

- Istio configuration manifests
- Network policy definitions
- Traffic management rules
- Security policy implementation
- Canary deployment scripts

---

### 🟡 Challenge 6: Monitoring, Logging & Observability

**Level: INTERMEDIATE** | **Prerequisites: Challenge 2 (can be done in parallel with others)**

**Objective:** Implement comprehensive monitoring and logging solutions using cloud-native tools and GCP services.

**What You'll Build:**

- **Prometheus** deployment using native K8s manifests
- **Grafana** dashboards for application and cluster metrics
- **Google Cloud Logging** integration
- **Google Cloud Monitoring** for GKE clusters
- **Alertmanager** configuration for incident response
- **Jaeger** for distributed tracing
- **Custom metrics** collection from applications
- **Log aggregation** and analysis pipelines

**Skills Learned:**

- **Observability** pillars (metrics, logs, traces)
- **Prometheus** configuration and querying
- **Grafana** dashboard creation
- **GCP monitoring** services integration
- **Alert management** and escalation
- **Distributed tracing** implementation

**Deliverables:**

- Monitoring stack deployment manifests
- Custom Grafana dashboards
- Alert rules configuration
- Log analysis queries
- Observability documentation

---

### 🟡 Challenge 7: Auto-scaling & Resource Management

**Level: INTERMEDIATE** | **Prerequisites: Challenge 6**

**Objective:** Implement intelligent scaling and resource management for optimal performance and cost efficiency.

**What You'll Build:**

- **Horizontal Pod Autoscaler (HPA)** with custom metrics
- **Vertical Pod Autoscaler (VPA)** for resource optimization
- **Cluster Autoscaler** configuration
- **Node pool management** for different workload types
- **Resource quotas** and **limit ranges**
- **Pod Disruption Budgets (PDB)** for high availability
- **Quality of Service (QoS)** classes implementation

**Skills Learned:**

- **Auto-scaling** strategies and configurations
- **Resource optimization** techniques
- **Cost management** in Kubernetes
- **High availability** patterns
- **Performance tuning** for containerized applications
- **Capacity planning** methodologies

**Deliverables:**

- Auto-scaling configurations
- Resource management policies
- Performance testing results
- Cost optimization report
- Capacity planning documentation

---

### 🔴 Challenge 8: Security & RBAC Implementation

**Level: EXPERT** | **Prerequisites: Challenge 3, Security fundamentals**

**Objective:** Implement comprehensive security measures including RBAC, network security, and security scanning.

**What You'll Build:**

- **Role-Based Access Control (RBAC)** policies
- **Service Accounts** with least privilege principles
- **Pod Security Standards** enforcement
- **Network security policies**
- **Image scanning** integration
- **Security contexts** for containers
- **Admission controllers** for policy enforcement
- **Vulnerability scanning** automation

**Skills Learned:**

- **Kubernetes security** best practices
- **RBAC** design and implementation
- **Container security** hardening
- **Network security** in Kubernetes
- **Compliance** and **governance**
- **Security automation** and scanning

**Deliverables:**

- RBAC policy definitions
- Security policy manifests
- Vulnerability scan reports
- Security baseline documentation
- Compliance audit results

---

### 🟡 Challenge 9: Advanced CI/CD with GitHub Actions & K8s

**Level: INTERMEDIATE** | **Prerequisites: Challenge 2, GitHub Actions experience**

**Objective:** Implement sophisticated CI/CD pipelines using GitHub Actions for automated deployment to GKE clusters.

**What You'll Build:**

- **GitHub Actions workflows** for automated testing and deployment
- **Multi-stage deployment** pipelines (build → test → deploy)
- **Environment-specific** deployment strategies
- **Rollback mechanisms** using GitHub Actions
- **Security scanning** integration in CI/CD
- **Automated testing** for K8s manifests (kubeval, conftest)
- **Deployment approval** workflows for production
- **Notification systems** for deployment status

**Skills Learned:**

- **Advanced GitHub Actions** workflows
- **CI/CD pipeline** optimization for Kubernetes
- **Automated testing** strategies for K8s
- **Security integration** in deployment pipelines
- **Environment promotion** workflows
- **Rollback automation** and **health checks**

**Deliverables:**

- Multi-environment GitHub Actions workflows
- Ansible playbooks for automated testing
- Security scanning integration via Ansible
- Deployment approval processes
- Ansible-based rollback automation

---

### 🔴 Challenge 10: Multi-Environment & Blue-Green Deployments

**Level: EXPERT** | **Prerequisites: Challenge 9, Advanced deployment concepts**

**Objective:** Implement sophisticated deployment strategies across multiple environments with zero-downtime deployments.

**What You'll Build:**

- **Multi-environment** cluster setup (dev/staging/prod)
- **Blue-Green deployment** strategies
- **Canary releases** with traffic shifting
- **Feature flags** integration
- **Environment promotion** pipelines
- **Database migration** strategies
- **Rollback mechanisms** and **health checks**

**Skills Learned:**

- **Advanced deployment** patterns
- **Environment management** strategies
- **Zero-downtime deployment** techniques
- **Risk mitigation** in deployments
- **Feature flag** implementation
- **Database versioning** in K8s

**Deliverables:**

- Multi-environment configurations
- Ansible playbooks for blue-green deployments
- Automated canary release via Ansible
- PostgreSQL database migration automation
- Deployment strategy documentation

---

---

## Learning Path Recommendations

### 🟢 **BEGINNER PATH** (New to Kubernetes)

```
Challenge 1 → Challenge 2 → Challenge 6 (basic monitoring)
```

**Focus:** Core Kubernetes concepts, basic deployments, essential monitoring

### 🟡 **INTERMEDIATE PATH** (Some K8s experience)

```
Challenge 1 → Challenge 2 → Challenge 3 → Challenge 4 →
Challenge 6 → Challenge 7 → Challenge 9
```

**Focus:** Production-ready deployments, configuration management, CI/CD integration

### 🔴 **EXPERT PATH** (Full production expertise)

```
All Challenges (1-10) + Advanced customizations
```

**Focus:** Enterprise-grade implementations, security, advanced networking

### 📚 **Recommended Sequential Order**

```
Challenge 1 → Challenge 2 → Challenge 3 → Challenge 4 →
Challenge 6 → Challenge 7 → Challenge 9 → Challenge 8 →
Challenge 5 → Challenge 10
```

**Note:** Challenge 6 (Monitoring) can be started early and run parallel with others

### 📚 **Parallel Learning Tracks**

Some challenges can be done simultaneously:

- **Monitoring (Challenge 6)** can start after Challenge 2
- **Security (Challenge 8)** concepts can be learned alongside any challenge
- **CI/CD (Challenge 9)** can be integrated throughout the journey

## Difficulty Breakdown

### 🟢 **BEGINNER Challenges (2)**

- **Prerequisites:** Basic Docker knowledge, willingness to learn
- **Skills Focus:** K8s fundamentals, basic deployments

### 🟡 **INTERMEDIATE Challenges (5)**

- **Prerequisites:** Completed beginner challenges, some ops experience
- **Skills Focus:** Production configurations, automation, monitoring

### 🔴 **EXPERT Challenges (3)**

- **Prerequisites:** Strong K8s foundation, enterprise experience helpful
- **Skills Focus:** Advanced patterns, security, optimization, business continuity

## Required Tools & Setup

### **Core Tools (Must Have)**

```bash
# Kubernetes & GCP
kubectl                    # Kubernetes CLI
gcloud                     # Google Cloud SDK
terraform                  # Infrastructure as Code
ansible                    # Automation & Configuration Management
git                        # Version control

# Container & Development
docker                     # Container runtime
node.js & npm             # For Fastify application
code/vim                   # Code editor
```

### **Installation Commands**

```bash
# Install gcloud CLI
curl https://sdk.cloud.google.com | bash

# Install kubectl
gcloud components install kubectl

# Install Terraform
# Download from: https://developer.hashicorp.com/terraform/downloads

# Install Ansible
pip3 install ansible
# Or on Ubuntu: sudo apt install ansible

# Verify installations
gcloud version
kubectl version --client
terraform version
ansible --version
docker version
```

### **GCP Setup Requirements**

```bash
# 1. Create GCP Project
gcloud projects create YOUR-PROJECT-ID

# 2. Enable required APIs
gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com
gcloud services enable storage.googleapis.com
gcloud services enable secretmanager.googleapis.com

# 3. Set up authentication
gcloud auth login
gcloud auth application-default login

# 4. Set default project
gcloud config set project YOUR-PROJECT-ID
```

### **Optional Tools (Nice to Have)**

```bash
kubectx & kubens          # Context/namespace switching
k9s                       # Terminal-based K8s UI
stern                     # Multi-pod log tailing
kustomize                 # Configuration management (built into kubectl)
```

### **Local Development Environment**

- **OS:** Ubuntu 22.04 LTS, macOS, or Windows with WSL2
- **RAM:** Minimum 8GB (16GB recommended)
- **Storage:** 50GB+ free space for containers and images
- **Network:** Stable internet for GCP access

### **GCP Cost Considerations**

- **GKE Cluster:** ~$74/month per cluster (management fee)
- **Node Instances:** Varies by machine type (~$25-100/month per node)
- **Persistent Storage:** ~$0.04/GB/month for SSD storage
- **Storage & Networking:** Additional costs based on usage
- **Free Tier:** $300 credit for new accounts (valid for 90 days)

**Recommendation:** Start with small clusters (1-2 nodes, e2-medium instances) and 10GB storage for PostgreSQL to minimize costs while learning.

## Getting Started

1. **Fork this repository** and set up your project structure
2. **Set up GCP account** and enable required APIs
3. **Install required tools** (kubectl, gcloud, terraform, ansible)
4. **Configure Ansible inventory** for your environments
5. **Start with Challenge 1:** Create your first GKE cluster using Terraform + Ansible
6. **Document your journey** thoroughly for portfolio purposes

## Key Learning Outcomes

By completing these challenges, you will have:

- **Production-ready Kubernetes expertise** on GKE
- **Complete CI/CD pipeline** with GitHub Actions integration
- **Advanced security** and **monitoring** implementations
- **Scalable infrastructure** with proper resource management
- **Multi-environment deployment** strategies
- **Portfolio-worthy** DevOps project demonstrating enterprise-level skills

## Portfolio Highlights

This project demonstrates:

- **Full-stack DevOps** capabilities
- **Cloud-native** architecture design
- **Infrastructure as Code** mastery
- **Security-first** approach
- **Cost optimization** awareness
- **Production-ready** implementations
