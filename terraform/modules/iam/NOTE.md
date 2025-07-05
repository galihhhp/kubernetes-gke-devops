# Field-by-Field Explanation of main.tf (IAM Module)

This document explains every field in main.tf, in the exact order they appear, in English, with the why, effect, trade-off, and analogy for each one.

---

## locals { service_account_roles = ... }

- Why: Makes it easier to assign roles programmatically.
- Effect: Simplifies mapping, reduces manual errors.
- Trade-off: Slightly more complex logic.
- Analogy: Like making a master checklist for the security team to issue all badges efficiently.

## google_service_account "workload_service_accounts"

- Why: Each component gets its own identity for least privilege.
- Effect: Granular access, easy to audit and revoke.
- Trade-off: More service accounts to manage.
- Analogy: Every department gets its own badge printer.
- account_id: The unique name for the service account. Like a badge ID.
- display_name: Human-readable name. Like a name tag on the badge.
- description: Explains the purpose. Like a note on the badge for security staff.

## google_project_iam_member "workload_service_account_roles"

- Why: Ensures each account only gets the access it needs.
- Effect: Least privilege, granular control.
- Trade-off: Mapping errors can cause over/under-permission.
- Analogy: Each badge is programmed for the right doors.
- project: Which building the badge works in.
- role: Which doors it opens.
- member: Who gets the badge.

## google_service_account_iam_binding "workload_identity_bindings"

- Why: Allows K8s workloads to use GCP APIs securely, keyless.
- Effect: Keyless, auditable, secure access.
- Trade-off: More complex setup.
- Analogy: Lets an employee use their department badge to open building doors, but only while on shift.
- service_account_id: Which badge to bind.
- role: The binding role (always Workload Identity User).
- members: The K8s identity allowed to use the badge.

## google_service_account "cicd_service_account"

- Why: CI/CD needs its own identity for automation.
- Effect: Secure, auditable automation.
- Trade-off: Another account to manage.
- Analogy: Like a robot with a special badge for deliveries and maintenance.

## google_project_iam_member "cicd_service_account_roles"

- Why: Least privilege for automation.
- Effect: Secure, auditable automation.
- Trade-off: If you miss a role, automation might break.
- Analogy: Robot only gets access to the rooms it needs.

## google_service_account "gke_node_service_account"

- Why: GKE nodes need their own identity for logging, monitoring, etc.
- Effect: Secure, auditable node operations.
- Trade-off: Another account to manage.
- Analogy: Like giving cleaning staff a badge for supply closets and break rooms.

## google_project_iam_member "gke_node_service_account_roles"

- Why: Least privilege for nodes.
- Effect: Secure, auditable node operations.
- Trade-off: If you miss a role, node features might break.
- Analogy: Cleaning staff can only access the logbook and supply closet, not the safe.

## google_project_iam_member "iap_tunnel_user"

- Why: Only trusted users can access the bastion via IAP.
- Effect: Secure, auditable access.
- Trade-off: If you forget to add a user, they can't access.
- Analogy: Like giving a trusted guard a secret tunnel key.

## google_project_iam_member "oslogin_user"

- Why: Only trusted users can SSH via IAM.
- Effect: Secure, auditable SSH access.
- Trade-off: If you forget to add a user, they can't SSH.
- Analogy: Like giving a guard a secure login badge.

---

## Summary Table

| Resource/Field                        | Why                                                             | Effect                                     | Trade-off                                       | Analogy                                |
| :------------------------------------ | :-------------------------------------------------------------- | :----------------------------------------- | :---------------------------------------------- | :------------------------------------- |
| locals.service_account_roles          | Makes it easier to assign roles programmatically.               | Simplifies mapping, reduces manual errors. | Slightly more complex logic.                    | Master checklist for badges            |
| google_service_account.workload...    | Each component gets its own identity for least privilege.       | Granular access, easy to audit and revoke. | More service accounts to manage.                | Badge printer per department           |
| google_project_iam_member.workload... | Ensures each account only gets the access it needs.             | Least privilege, granular control.         | Mapping errors can cause over/under-permission. | Badge programmed for right doors       |
| google_service_account_iam_binding... | Allows K8s workloads to use GCP APIs securely, keyless.         | Keyless, auditable, secure access.         | More complex setup.                             | Badge works only while on shift        |
| google_service_account.cicd...        | CI/CD needs its own identity for automation.                    | Secure, auditable automation.              | Another account to manage.                      | Robot with special badge               |
| google_project_iam_member.cicd...     | Least privilege for automation.                                 | Secure, auditable automation.              | If you miss a role, automation might break.     | Robot only gets needed rooms           |
| google_service_account.gke_node...    | GKE nodes need their own identity for logging, monitoring, etc. | Secure, auditable node operations.         | Another account to manage.                      | Cleaning staff badge                   |
| google_project_iam_member.gke_node... | Least privilege for nodes.                                      | Secure, auditable node operations.         | If you miss a role, node features might break.  | Cleaning staff only gets supply closet |
| google_project_iam_member.iap_tunnel  | Only trusted users can access the bastion via IAP.              | Secure, auditable access.                  | If you forget to add a user, they can't access. | Guard with secret tunnel key           |
| google_project_iam_member.oslogin...  | Only trusted users can SSH via IAM.                             | Secure, auditable SSH access.              | If you forget to add a user, they can't SSH.    | Guard with secure login badge          |
