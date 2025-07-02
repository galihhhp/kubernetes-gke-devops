# Field-by-Field Explanation of main.tf (Bastion Module)

This document explains every field in main.tf, in the exact order they appear, in English, with the why, effect, trade-off, and analogy for each one.

---

## google_compute_instance "bastion"

- name:
  - Why: Easy to find and audit.
  - Effect: Clear identification.
  - Trade-off: None.
  - Analogy: Naming your guardhouse at the city gate.
- machine_type:
  - Why: Cost-efficient, enough for admin tasks.
  - Effect: Low cost, sufficient for SSH/IAP.
  - Trade-off: Not for heavy workloads.
  - Analogy: Choosing a small guardhouse—enough for the guards, not a palace.
- zone:
  - Why: Proximity to resources, compliance.
  - Effect: Lower latency, local data.
  - Trade-off: Must match other resources.
  - Analogy: Picking which city district your guardhouse is in.
- boot_disk { initialize_params { image, size } }:
  - Why: Stable, secure OS, just enough storage.
  - Effect: Fewer bugs, lower cost, less attack surface.
  - Trade-off: Can't store large files.
  - Analogy: The blueprint and storage space for the guardhouse—what tools and supplies are inside.
- network_interface { network, subnetwork, access_config {} }:
  - Why: Ensures correct placement and remote access.
  - Effect: Proper isolation, can SSH/IAP in.
  - Trade-off: Public IP is a risk if not secured.
  - Analogy: Placing the guardhouse at the city wall with a door to the outside.
- tags = ["bastion"]:
  - Why: Easy to manage access and security.
  - Effect: Can target firewall rules.
  - Trade-off: If you forget to set tags in firewall, access can break.
  - Analogy: Marking the guardhouse for special security rules.
- metadata = merge(var.metadata, { enable-oslogin = "TRUE", startup-script = file("${path.module}/bastion_startup.sh") }):
  - Why: Secure, auditable access, ready-to-use VM.
  - Effect: Only trusted users can SSH, tools are pre-installed.
  - Trade-off: If script fails, manual fix needed.
  - Analogy: Giving guards a secure login system and a morning checklist.

---

## Summary Table

| Field/Resource    | Why                                    | Effect                          | Trade-off                   | Analogy                              |
| ----------------- | -------------------------------------- | ------------------------------- | --------------------------- | ------------------------------------ |
| name              | Easy to find and audit                 | Clear identification            | None                        | Naming your guardhouse               |
| machine_type      | Cost-efficient, enough for admin       | Low cost, sufficient for SSH    | Not for heavy workloads     | Small guardhouse, not a palace       |
| zone              | Proximity to resources, compliance     | Lower latency, local data       | Must match resources        | Picking city district                |
| boot_disk         | Stable, secure OS, just enough storage | Fewer bugs, low cost, less risk | Can't store large files     | Blueprint and storage for guardhouse |
| network_interface | Ensures placement and remote access    | Proper isolation, SSH/IAP       | Public IP is a risk         | Door to the outside                  |
| tags              | Easy to manage access/security         | Can target firewall rules       | Missed tag breaks access    | Marking for special security         |
| metadata          | Secure, auditable, ready-to-use        | Trusted SSH, tools installed    | Script failure = manual fix | Secure login, morning checklist      |
