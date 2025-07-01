# NOTE

## Why This Setup? (Resource-by-Resource)

This module builds a secure, scalable, and observable network for your GCP workloads. Here's the reasoning for every resource and setting, with analogies:

- **google_compute_network.vpc_network**
  Why: Creates a dedicated VPC for all workloads. Analogy: Like building a walled city—your own space, isolated from the outside world. `auto_create_subnetworks = false` means you design every street (subnet) yourself, not Google.

- **google_compute_subnetwork.subnet**
  Why: Custom subnet for granular IP control. Secondary ranges for pods/services prevent address conflicts. Analogy: Like giving every building (workload) and mailbox (service) a unique address. `private_ip_google_access = true` lets residents use Google services without leaving the city walls.

- **log_config in subnet**
  Why: Enables VPC flow logs for traffic visibility. Analogy: Like installing CCTV on every street to monitor traffic and spot trouble.

- **google_compute_router.router**
  Why: Dynamic routing for hybrid/cloud-native networking. Analogy: Like a city's traffic control center, managing routes for all vehicles.

- **google_compute_address.nat_ip & google_compute_router_nat.nat**
  Why: NAT lets private resources access the internet without exposing their real addresses. Analogy: Like a guarded city gate—residents can go out, but outsiders can't come in. Manual IP allocation gives you control over which gate is used.

- **log_config in NAT**
  Why: Logs all NAT traffic for auditing. Analogy: Like keeping a logbook at the city gate.

- **Firewall Rules**

  - **load_balancer**: Allows only Google's load balancer IPs to reach frontend on port 3000. Analogy: Like a VIP lane for delivery trucks to the main market.
  - **frontend_to_backend**: Only frontend can reach backend on port 5173. Analogy: Like a private corridor between the shop and the storeroom.
  - **backend_to_db**: Only backend can reach PostgreSQL on 5432. Analogy: Like a dumbwaiter from the kitchen to the vault—no direct public access.
  - **monitoring**: Only monitoring services can reach nodes on 9090/9091. Analogy: Like letting inspectors into utility rooms, but not the main hall.
  - **health_checks**: Allows GCP health checks to nodes on 8080/10256. Analogy: Like letting city inspectors check building safety.
  - **internal_communication**: Allows all TCP/UDP/ICMP within the subnet. Analogy: Like letting all residents talk to each other inside the city.
  - **deny_public_db**: Blocks all public access to PostgreSQL. Analogy: Like putting a vault behind a locked, guarded door—no outsiders allowed.
  - **deny_public_backend**: Blocks all public access to backend. Analogy: Like making the storeroom invisible to the public.

- **Tags**
  Why: Used to target firewall rules to specific workloads. Analogy: Like color-coded badges for different buildings—only certain colors get through certain doors.

- **Outputs**
  Why: Expose all key network details (IDs, CIDRs, tags) for use by other modules. Analogy: Like handing out a detailed city map to planners and builders.

## Analogy

This setup is like designing a fortress city: you control every wall, gate, street, and checkpoint, monitor all comings and goings, and make sure only the right people can access the right places—keeping your citizens safe and your city running smoothly.
