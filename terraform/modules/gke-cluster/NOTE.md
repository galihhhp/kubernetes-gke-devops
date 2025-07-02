# Field-by-Field Explanation of main.tf (GKE Cluster Module)

This document explains every field in main.tf, in the exact order they appear, in English, with the why, effect, trade-off, and analogy for each one.

---

data "google_compute_network" "network"

- name:
  - Why: Ensures the cluster is built in the right place.
  - Effect: Proper isolation and connectivity.
  - Trade-off: Must exist already.
  - Analogy: Picking the right neighborhood before building your house.

data "google_compute_subnetwork" "subnet"

- name, region:
  - Why: Ensures pods/services get the right IPs.
  - Effect: Predictable, secure networking.
  - Trade-off: Must exist already.
  - Analogy: Picking the right street for your house.

resource "google_container_cluster" "main"

- name:
  - Why: Clear identification.
  - Effect: Easy to find, audit.
  - Trade-off: None.
  - Analogy: Naming your restaurant.
- location:
  - Why: Proximity to users/resources.
  - Effect: Lower latency.
  - Trade-off: Must match region.
  - Analogy: Picking a city district.
- remove_default_node_pool:
  - Why: Custom node pools for security/scaling.
  - Effect: More control.
  - Trade-off: More setup.
  - Analogy: Tearing down the default kitchen to build your own.
- initial_node_count:
  - Why: Minimal start, autoscaling handles the rest.
  - Effect: Cost-efficient.
  - Trade-off: Not HA by default.
  - Analogy: Opening with a skeleton crew.
- network, subnetwork:
  - Why: Ensures correct placement.
  - Effect: Proper isolation.
  - Trade-off: Must exist.
  - Analogy: Picking the right lot for your restaurant.
- deletion_protection:
  - Why: Prevents accidental deletion.
  - Effect: Harder to destroy by mistake.
  - Trade-off: Must disable to destroy.
  - Analogy: Lock on the main power switch.
- logging_service, monitoring_service:
  - Why: Enables GCP-native logging/monitoring.
  - Effect: Easier to debug, audit.
  - Trade-off: Slight cost.
  - Analogy: Security cameras and smoke detectors.
- enable_shielded_nodes:
  - Why: Protects from rootkits/boot attacks.
  - Effect: More secure.
  - Trade-off: None.
  - Analogy: Tamper-proof locks.
- network_policy:
  - Why: Enforces pod-to-pod rules.
  - Effect: Only right pods talk.
  - Trade-off: More config.
  - Analogy: Doors/locks between rooms.
- cluster_autoscaling:
  - Why: Cost and performance.
  - Effect: Scales up/down as needed.
  - Trade-off: More moving parts.
  - Analogy: Hiring more staff during rush hour.
- private_cluster_config:
  - Why: No public IPs for nodes/master.
  - Effect: No public exposure.
  - Trade-off: Harder to debug.
  - Analogy: Gated community with private roads.
- ip_allocation_policy:
  - Why: Uses secondary ranges.
  - Effect: Prevents IP conflicts.
  - Trade-off: More planning.
  - Analogy: Mailboxes for every apartment.
- master_authorized_networks_config:
  - Why: Restricts master API access.
  - Effect: Only trusted CIDRs can access.
  - Trade-off: Can lock yourself out.
  - Analogy: Only friends/family have keys to your front door.
- maintenance_policy:
  - Why: Schedules updates.
  - Effect: Updates outside business hours.
  - Trade-off: Must plan windows.
  - Analogy: Cleaning the kitchen after hours.
- workload_identity_config:
  - Why: Securely links GCP IAM and K8s SAs.
  - Effect: Keyless, auditable.
  - Trade-off: More setup.
  - Analogy: Chef badge works for both kitchen and supply room.
- resource_labels:
  - Why: Tags for environment/cost tracking.
  - Effect: Easier to filter/track.
  - Trade-off: None.
  - Analogy: Labeling all your kitchen equipment.

resource "google_container_node_pool" "main_node"

- name:
  - Why: Clear identification.
  - Effect: Easy to find, audit.
  - Trade-off: None.
  - Analogy: Naming your staff team.
- location:
  - Why: Proximity to cluster.
  - Effect: Lower latency.
  - Trade-off: Must match cluster.
  - Analogy: Staff work in the same branch.
- cluster:
  - Why: Ensures correct placement.
  - Effect: Proper operation.
  - Trade-off: Must exist.
  - Analogy: Assigning staff to the right restaurant.
- autoscaling:
  - Why: Controls node count.
  - Effect: Scales up/down as needed.
  - Trade-off: More moving parts.
  - Analogy: Adjusting number of tables based on reservations.
- node_config:
  - Why: Custom resources, security.
  - Effect: Right size/features for workload.
  - Trade-off: More config.
  - Analogy: Choosing the right oven/fridge for your kitchen.
  - preemptible:
    - Why: Use cheaper, short-lived nodes.
    - Effect: Cheaper, but can be evicted.
    - Trade-off: Less reliable.
    - Analogy: Hiring temp staff for busy days.
  - machine_type, disk_size_gb:
    - Why: Fit workload needs.
    - Effect: Right performance/cost.
    - Trade-off: Must plan.
    - Analogy: Picking oven/fridge size.
  - tags:
    - Why: For firewall/workload separation.
    - Effect: Easier to manage.
    - Trade-off: More planning.
    - Analogy: Color-coding aprons.
  - service_account:
    - Why: Node identity.
    - Effect: Least privilege.
    - Trade-off: Must manage SAs.
    - Analogy: Staff get a list of rooms they can enter.
  - oauth_scopes:
    - Why: GCP API access.
    - Effect: More features.
    - Trade-off: More permissions.
    - Analogy: Master key for supply rooms.
  - workload_metadata_config:
    - Why: Secure metadata.
    - Effect: Only right pods get info.
    - Trade-off: More config.
    - Analogy: Secure way for staff to check schedules.
  - labels:
    - Why: Node-level labels.
    - Effect: Easier to manage.
    - Trade-off: More planning.
    - Analogy: Stickers on equipment.

---

## Summary Table

| Field/Resource                      | Why                                              | Effect                             | Trade-off                | Analogy                                                    |
| ----------------------------------- | ------------------------------------------------ | ---------------------------------- | ------------------------ | ---------------------------------------------------------- |
| network                             | Ensures the cluster is built in the right place. | Proper isolation and connectivity. | Must exist already.      | Picking the right neighborhood before building your house. |
| subnetwork                          | Ensures pods/services get the right IPs.         | Predictable, secure networking.    | Must exist already.      | Picking the right street for your house.                   |
| cluster                             | Clear identification.                            | Easy to find, audit.               | None.                    | Naming your restaurant.                                    |
| location                            | Proximity to users/resources.                    | Lower latency.                     | Must match region.       | Picking a city district.                                   |
| remove_default_node_pool            | Custom node pools for security/scaling.          | More control.                      | More setup.              | Tearing down the default kitchen to build your own.        |
| initial_node_count                  | Minimal start, autoscaling handles the rest.     | Cost-efficient.                    | Not HA by default.       | Opening with a skeleton crew.                              |
| network, subnetwork                 | Ensures correct placement.                       | Proper isolation.                  | Must exist.              | Picking the right lot for your restaurant.                 |
| deletion_protection                 | Prevents accidental deletion.                    | Harder to destroy by mistake.      | Must disable to destroy. | Lock on the main power switch.                             |
| logging_service, monitoring_service | Enables GCP-native logging/monitoring.           | Easier to debug, audit.            | Slight cost.             | Security cameras and smoke detectors.                      |
| enable_shielded_nodes               | Protects from rootkits/boot attacks.             | More secure.                       | None.                    | Tamper-proof locks.                                        |
| network_policy                      | Enforces pod-to-pod rules.                       | Only right pods talk.              | More config.             | Doors/locks between rooms.                                 |
| cluster_autoscaling                 | Cost and performance.                            | Scales up/down as needed.          | More moving parts.       | Hiring more staff during rush hour.                        |
| private_cluster_config              | No public IPs for nodes/master.                  | No public exposure.                | Harder to debug.         | Gated community with private roads.                        |
| ip_allocation_policy                | Uses secondary ranges.                           | Prevents IP conflicts.             | More planning.           | Mailboxes for every apartment.                             |
| master_authorized_networks_config   | Restricts master API access.                     | Only trusted CIDRs can access.     | Can lock yourself out.   | Only friends/family have keys to your front door.          |
| maintenance_policy                  | Schedules updates.                               | Updates outside business hours.    | Must plan windows.       | Cleaning the kitchen after hours.                          |
| workload_identity_config            | Securely links GCP IAM and K8s SAs.              | Keyless, auditable.                | More setup.              | Chef badge works for both kitchen and supply room.         |
| resource_labels                     | Tags for environment/cost tracking.              | Easier to filter/track.            | None.                    | Labeling all your kitchen equipment.                       |
| node_pool                           | Clear identification.                            | Easy to find, audit.               | None.                    | Naming your staff team.                                    |
| autoscaling                         | Controls node count.                             | Scales up/down as needed.          | More moving parts.       | Adjusting number of tables based on reservations.          |
| node_config                         | Custom resources, security.                      | Right size/features for workload.  | More config.             | Choosing the right oven/fridge for your kitchen.           |
| preemptible                         | Use cheaper, short-lived nodes.                  | Cheaper, but can be evicted.       | Less reliable.           | Hiring temp staff for busy days.                           |
| machine_type, disk_size_gb          | Fit workload needs.                              | Right performance/cost.            | Must plan.               | Picking oven/fridge size.                                  |
| tags                                | For firewall/workload separation.                | Easier to manage.                  | More planning.           | Color-coding aprons.                                       |
| service_account                     | Node identity.                                   | Least privilege.                   | Must manage SAs.         | Staff get a list of rooms they can enter.                  |
| oauth_scopes                        | GCP API access.                                  | More features.                     | More permissions.        | Master key for supply rooms.                               |
| workload_metadata_config            | Secure metadata.                                 | Only right pods get info.          | More config.             | Secure way for staff to check schedules.                   |
| labels                              | Node-level labels.                               | Easier to manage.                  | More planning.           | Stickers on equipment.                                     |
