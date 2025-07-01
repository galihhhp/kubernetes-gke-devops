# NOTE

## Why This Setup? (Resource-by-Resource)

This module provisions a production-grade GKE cluster. Here's the reasoning for every resource and setting, with analogies:

- **data.google_compute_network.network & data.google_compute_subnetwork.subnet**
  Why: Reference existing VPC/subnet for cluster placement. Analogy: Like picking the right neighborhood and street before building your house.

- **google_container_cluster.main**

  - **remove_default_node_pool**: Removes the default node pool so you can create custom ones. Analogy: Like tearing down the default kitchen to build your own, tailored to your needs.
  - **deletion_protection**: Prevents accidental cluster deletion. Analogy: Like putting a lock on the main power switch.
  - **logging_service & monitoring_service**: Enable GCP-native logging/monitoring. Analogy: Like installing security cameras and smoke detectors in every room.
  - **enable_shielded_nodes**: Protects nodes from rootkits and boot-level attacks. Analogy: Like using tamper-proof locks on all doors.
  - **network_policy.enabled**: Enforces pod-to-pod network rules. Analogy: Like putting doors and locks between rooms so only the right people (pods) can enter.
  - **cluster_autoscaling**: Scales nodes up/down based on demand, with CPU/memory limits. Analogy: Like hiring more staff during rush hour and sending them home when it's quiet, but never exceeding your budget.
  - **private_cluster_config**: Nodes/master have no public IPs; master has a private CIDR. Analogy: Like a gated community with private roads—outsiders can't just walk in.
  - **ip_allocation_policy**: Uses secondary ranges for pods/services. Analogy: Like giving every apartment (pod/service) its own mailbox number.
  - **master_authorized_networks_config**: Only specific CIDRs can access the master API. Analogy: Only trusted friends/family have keys to your front door.
  - **maintenance_policy**: Schedules regular maintenance windows. Analogy: Like planning cleaning times for your kitchen so it's always ready for service.
  - **workload_identity_config**: Securely links GCP IAM with Kubernetes service accounts. Analogy: Like giving each chef a badge that works for both the kitchen and the supply room.
  - **resource_labels**: Tags for environment/cost tracking. Analogy: Like labeling all your kitchen equipment so you know what's for prep, cook, or clean.

- **google_container_node_pool.main_node**
  - **autoscaling**: Node pool scales between min/max nodes. Analogy: Like adjusting the number of tables in your restaurant based on reservations.
  - **node_config.preemptible**: Uses cheaper, short-lived nodes for non-critical workloads. Analogy: Like hiring temp staff for busy days.
  - **machine_type & disk_size_gb**: Customizes node resources. Analogy: Like choosing the right oven and fridge size for your kitchen.
  - **tags**: Used for firewall rules and workload separation. Analogy: Like color-coding aprons for different roles.
  - **service_account**: Controls what cloud resources nodes can access. Analogy: Like giving each chef a list of rooms they're allowed to enter.
  - **oauth_scopes**: Grants nodes access to GCP APIs. Analogy: Like giving staff a master key for certain supply rooms.
  - **workload_metadata_config**: Securely exposes metadata to workloads. Analogy: Like giving staff a secure way to check their schedules.
  - **labels**: Node-level labels for workload scheduling. Analogy: Like putting stickers on equipment to show what it's for.

## Outputs

All key cluster/node details (IDs, names, endpoints, labels, etc.) are exposed for use by other modules or automation. Analogy: Like handing out a detailed blueprint and staff directory to managers and planners.

## Analogy

This setup is like building a secure, scalable, and well-organized restaurant: you pick the right location, control who enters, scale staff up/down, label everything, and keep the whole operation safe and efficient.
