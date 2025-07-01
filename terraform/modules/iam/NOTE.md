# NOTE

## Why This Setup? (Deep Dive: Resource, Field, Variable, Output)

This module is designed for granular, least-privilege IAM in GCP. Here's the why for every variable, resource, field, and output, with analogies for each.

### Variables

- **project_id**: Specifies which GCP project to manage. Analogy: Like picking which building you're setting up security for.
- **environment**: Used for naming and scoping (dev, prod). Analogy: Like labeling badges for "staff" vs "VIP."
- **workload_identity_bindings**: Map of all app components and their K8s/GCP service account mapping and roles. Analogy: Like a master list of who needs access to which rooms, and what keys they get.
  - **k8s_namespace**: Which K8s namespace the workload runs in. Analogy: Like which department in a company.
  - **k8s_service_account_name**: The K8s service account name. Analogy: Like the employee's name in the department.
  - **gcp_service_account_name**: The GCP service account name. Analogy: Like the badge ID for the building.
  - **roles**: List of GCP IAM roles to grant. Analogy: Like a list of doors the badge can open.
- **enable_workload_identity**: Whether to enable Workload Identity bindings. Analogy: Like turning on a new badge system after everyone's ready.

### Locals

- **service_account_roles**: This local block flattens the nested map of workload identity bindings into a flat map of (component, role) pairs. The `for` expressions iterate over each component and each role, and `merge([...])` combines all the resulting maps into one. This makes it easy to assign IAM roles to each service account in a single loop later. Analogy: Imagine you have a list of departments, and each department has a list of rooms they need access to. This block creates a master checklist where each line says, "Person from Department X needs access to Room Y," so the security team can issue all badges efficiently without missing any combinations.

  **Step-by-step logic for `locals.service_account_roles`:**

  1. Start with the `workload_identity_bindings` map, where each key is a component (e.g., frontend) and each value contains a list of roles.
  2. For each component, loop through its list of roles.
  3. For every (component, role) pair, create a map entry with a unique key ("component-role") and a value containing the component and role.
  4. Use `merge([...])` to combine all these small maps into one big flat map.
  5. The result: a single map where each key is a unique (component-role) string, and each value is an object with the component and role. This is used for easy, flat iteration when assigning IAM roles.

  Analogy: Imagine you have a table where each row is a department, and each cell in that row lists the rooms that department needs access to. This logic goes cell by cell, writing a new row for every department-room combo, so you end up with a long, flat checklist for the security team to process badge access efficiently.

### Resources

- **google_service_account.workload_service_accounts**
  - **for_each**: One per component. Analogy: Every department gets its own badge printer.
  - **account_id**: Unique per component. Analogy: Each badge has a unique number.
  - **display_name/description**: Human-friendly for auditing. Analogy: Like printing the employee's name and role on the badge.
- **google_project_iam_member.workload_service_account_roles**
  - **for_each**: One per (component, role) pair. Analogy: Each badge is programmed for the right doors.
  - **project/role/member**: Assigns the right permissions to the right badge in the right building.
- **google_service_account_iam_binding.workload_identity_bindings**
  - **for_each**: Only if enabled. Analogy: Only issue new badges when the new system is live.
  - **service_account_id/role/members**: Binds K8s and GCP identities. Analogy: Lets an employee use their department badge to open building doors, but only while on shift.
- **google_service_account.cicd_service_account**
  - **account_id/display_name/description**: Dedicated badge for automation. Analogy: Like a robot with a special badge for deliveries and maintenance.
- **google_project_iam_member.cicd_service_account_roles**
  - **for_each**: One per required CI/CD permission. Analogy: Robot only gets access to the rooms it needs.
- **google_service_account.gke_node_service_account**
  - **account_id/display_name/description**: Badge for GKE nodes. Analogy: Like giving cleaning staff a badge for supply closets and break rooms.
- **google_project_iam_member.gke_node_service_account_roles**
  - **for_each**: One per logging/monitoring permission. Analogy: Cleaning staff can only access the logbook and supply closet, not the safe.

### Outputs

- **cicd_service_account_email/name/id**: For automation to use the right badge. Analogy: Like giving the robot's badge info to the front desk.
- **workload_service_accounts**: Map of all app badges. Analogy: The full staff directory for security.
- **frontend_service_account_email/backend_service_account_email/database_service_account_email/monitoring_service_account_email**: Quick access to key badges. Analogy: Like a list of department heads.
- **workload_identity_bindings**: Shows which K8s accounts are linked to which GCP badges. Analogy: Like a log of who can use which badge, and when.
- **workload_identity_enabled**: Whether the new badge system is on. Analogy: Is the new security system live?
- **gke_node_service_account_email/id**: For GKE nodes to use the right badge. Analogy: Like giving the cleaning staff their own badge and tracking it.

## Analogy

This setup is like running a high-security building: every person, robot, and department gets a custom badge, only the right doors open, and you have a full log of who can go where, when, and why. Every field, variable, and output is about making access clear, auditable, and safe.
