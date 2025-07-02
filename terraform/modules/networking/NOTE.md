# Field-by-Field Explanation of main.tf (Networking Module)

This document explains every field in main.tf, in the exact order they appear, in English, with the why, effect, trade-off, and analogy for each one.

---

## google_compute_network "vpc_network"

- name: The VPC's name. Why: Easy to find and audit. Effect: Clear identification. Trade-off: None. Analogy: Naming your city.
- auto_create_subnetworks: Disabled for full control. Why: You want to design every subnet. Effect: More secure, predictable. Trade-off: More manual work. Analogy: Designing every street yourself.
- routing_mode: REGIONAL. Why: Keep traffic local for lower latency. Effect: Faster, more controlled routing. Trade-off: Can't route globally by default. Analogy: Local traffic control center.
- description: Human-readable context. Why: For clarity and audit. Effect: Easy to understand purpose. Trade-off: None. Analogy: City description on a map.

## google_compute_subnetwork "subnet"

- name: Subnet's name. Why: Consistency, easy management. Effect: Easy to find. Trade-off: None. Analogy: Naming a neighborhood.
- ip_cidr_range: Main CIDR. Why: Unique IPs, no overlap. Effect: Predictable addressing. Trade-off: Must plan carefully. Analogy: Assigning street addresses.
- region: Where the subnet lives. Why: Proximity to resources. Effect: Lower latency. Trade-off: None. Analogy: Picking a city district.
- network: Which VPC to use. Why: Ensures correct placement. Effect: Proper isolation. Trade-off: None. Analogy: Which city the neighborhood is in.
- secondary_ip_range: For pods/services. Why: Prevents IP conflicts. Effect: Native K8s routing. Trade-off: More planning. Analogy: Mailboxes for every building.
- private_ip_google_access: True. Why: VMs can access Google APIs without public IP. Effect: More secure. Trade-off: None. Analogy: Residents use city services without leaving.
- log_config: Enables VPC flow logs. Why: Visibility and audit. Effect: Can trace/debug traffic. Trade-off: Storage cost. Analogy: CCTV on every street.

## google_compute_router "router"

- name, region, network: Sets up routing. Why: Dynamic routing for hybrid/cloud. Effect: Flexible networking. Trade-off: More moving parts. Analogy: City traffic control center.

## google_compute_address "nat_ip"

- name, region: Reserves a static IP for NAT. Why: Auditability, control. Effect: Predictable egress. Trade-off: Must manage IPs. Analogy: Assigning a city gate for outgoing traffic.

## google_compute_router_nat "nat"

- name, router, region: Sets up NAT. Why: Allow private resources to access the internet. Effect: Secure outbound access. Trade-off: More config. Analogy: City gate for all outgoing traffic.
- nat_ip_allocate_option: MANUAL_ONLY. Why: Full control over IPs. Effect: Predictable, auditable. Trade-off: More manual work. Analogy: Assigning a specific gate.
- nat_ips: Which IPs to use. Why: Explicit control. Effect: No surprises. Trade-off: Must manage IPs. Analogy: Picking the gate.
- source_subnetwork_ip_ranges_to_nat: ALL_SUBNETWORKS_ALL_IP_RANGES. Why: All subnets can use NAT. Effect: Everything can reach out. Trade-off: None. Analogy: All neighborhoods use the same gate.
- log_config: Enables NAT logs. Why: Audit, debug. Effect: Traceable egress. Trade-off: Storage cost. Analogy: Logbook at the city gate.

## google_compute_firewall ...

Each firewall rule is crafted for least-privilege, only allowing the exact traffic needed. Why: Security, audit, and control. Effect: Only the right traffic flows. Trade-off: If you miss a rule, things break. Analogy: Giving each building a list of who can enter and when.

- load_balancer: Allows LB to frontend on port 3000. Analogy: VIP lane for delivery trucks.
- frontend_to_backend: Allows frontend to backend on 5173. Analogy: Private corridor from shop to storeroom.
- backend_to_db: Allows backend to PostgreSQL on 5432. Analogy: Dumbwaiter from kitchen to vault.
- monitoring: Allows monitoring to nodes on 9090/9091. Analogy: Inspectors into utility rooms.
- health_checks: Allows GCP health checks to nodes. Analogy: City inspectors check building safety.
- internal_communication: Allows all TCP/UDP/ICMP within subnet. Analogy: Residents talk inside city.
- deny_public_db: Blocks public access to PostgreSQL. Analogy: Vault behind a locked door.
- deny_public_backend: Blocks public access to backend. Analogy: Storeroom invisible to public.
- iap_ssh_bastion: Only allows IAP to SSH into bastion. Analogy: Secret tunnel for trusted guards.

---

## Summary Table

| Resource/Field | Why                       | Effect                      | Trade-off                 | Analogy                             |
| -------------- | ------------------------- | --------------------------- | ------------------------- | ----------------------------------- |
| vpc_network    | Naming, control           | Clear, auditable            | None                      | Naming your city                    |
| subnetwork     | Consistency, K8s, audit   | Predictable, secure         | More planning             | Naming a neighborhood               |
| router         | Dynamic routing           | Flexible, hybrid networking | More moving parts         | City traffic control center         |
| nat_ip         | Predictable egress        | Audit, control              | Must manage IPs           | Assigning a city gate               |
| nat            | Secure outbound           | Traceable, secure           | More config               | City gate for all outgoing traffic  |
| firewall rules | Least privilege, security | Only right traffic flows    | Miss a rule, things break | List of who can enter each building |
