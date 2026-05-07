# Run Profile Validation Rules

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 02.
Schema authority: [config/run-profile.schema.yaml](run-profile.schema.yaml)

This document lists the validation checks that any concrete `runs/<run_id>/run-profile.yaml` must satisfy before a run begins. Build Package 12 implements these as objective lint checks. Build Package 03 tools enforce a subset at run-folder creation time. The list here is the authoritative human-readable form.

A failing check stops the run. Lowering a check to make a failing run pass is forbidden by [validation/no-drift-rules.md](../validation/no-drift-rules.md).

## Check 1 — Required field presence

Every required field in [config/run-profile.schema.yaml](run-profile.schema.yaml) must be present and non-null. The required set is:

`schema_version`, `package_version`, `run_id`, `sample_id`, `mode`, `workspace_root`, `input_root`, `expected_root`, `output_root`, `old_reference_workspace`, `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url`, `output_destination_mode`, `postback_execution_status`, `jira_connector_status`, `confluence_connector_status`, `rovo_mcp_available`, `mcp_execution_status`, `operator_name`, `reviewer_name`, `sensitive_data_confirmed_redacted`, `expected_baseline_required`, `scoring_enabled`, `created_at`.

`notes` is optional and defaults to empty string.

## Check 2 — Type and enum validation

- Every enum field's value must be in its declared enum.
- Every boolean field's value must be `true` or `false`.
- Every string field's value must be a string (not null, not number, not list).
- Constants `schema_version` and `package_version` must equal the schema's `const` values.

## Check 3 — Identifier patterns

- `run_id` matches `^RUN-[A-Z0-9][A-Z0-9-]*$`, length 5–64.
- `sample_id` matches `^sample-[0-9]{3}[a-z0-9-]*$`, length 11–64.
- `created_at` matches `^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$`.

## Check 4 — Path resolution

- `input_root`, `expected_root`, `output_root` are all relative paths.
- No path contains a `..` parent-traversal segment.
- No path begins with a drive letter (`C:`, `D:`, etc.).
- No path begins with a leading `/`.
- `output_root` matches `^runs/RUN-[A-Z0-9][A-Z0-9-]*(/.*)?$` and the run_id segment matches `run_id`.
- `expected_root` may be empty only when `expected_baseline_required` is `false`.
- `workspace_root` is `.` (relative).

See [config/path-resolution-rules.md](path-resolution-rules.md) for examples.

## Check 5 — Mode coupling (folder-first family)

When `mode` is `folder_first_test`, `folder_first_review`, or `dry_run_revalidation`:

- `output_destination_mode` must be `local_only`.
- `postback_execution_status` must be `deferred`.
- `jira_connector_status` is `not_required` or `unavailable`.
- `confluence_connector_status` is `not_required` or `unavailable`.
- `mcp_execution_status` is `not_required` or `unavailable`.

Additionally, when `mode` is `folder_first_test` or `folder_first_review`:

- `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url` are all empty.
- `rovo_mcp_available` is `false`.

`dry_run_revalidation` may carry historical URLs for traceability if the operator records them honestly; post-back stays deferred regardless.

## Check 6 — Mode coupling (integration family)

When `mode` is `integration_assisted_intake` or `integration_assisted_postback`:

- At least one of `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url` is set, OR at least one connector status is not `not_required`.
- `postback_execution_status` remains `deferred` or `formatted_only` unless the operator has actually executed the post-back and recorded evidence.

When `mode` is `live_reviewer_run`:

- No connector defaults are forced. The operator declares connector posture honestly.
- `postback_execution_status` must reflect actual execution state; no claim without evidence.

## Check 7 — Output destination required URLs

- `output_destination_mode == jira_draft` ⇒ `destination_ticket_url` non-empty.
- `output_destination_mode == confluence_draft` ⇒ `destination_confluence_url` non-empty.
- `output_destination_mode == jira_and_confluence_draft` ⇒ both `destination_ticket_url` and `destination_confluence_url` non-empty.
- `output_destination_mode == external_postback_executed` ⇒ at least one of the two destination URLs is non-empty.

## Check 8 — Post-back honesty

- `output_destination_mode == external_postback_executed` ⇒ `postback_execution_status == executed_by_operator`.
- `postback_execution_status == executed_by_operator` ⇒ `output_destination_mode == external_postback_executed`.
- Build Package 11 must additionally require `output_root/00-run-log.md` to record timestamp, destination URL, and operator role before any artifact may claim post-back happened. No artifact may claim post-back execution without this run-log evidence.

## Check 9 — Connector and MCP honesty

- A connector status of `executed_by_operator` requires `postback_execution_status == executed_by_operator` and a corresponding destination URL non-empty.
- `mcp_execution_status == executed_by_operator` requires recorded MCP-execution evidence in the run log when Build Package 11 wires this check.
- `rovo_mcp_available == true` requires the operator to record availability evidence in the run log when integration modes are active.

## Check 10 — Sensitive-data validation

Every string field is screened against the prohibited substrings and patterns documented in [config/sensitive-data-rules.md](sensitive-data-rules.md), including but not limited to:

- `Bearer `, `Authorization:`, `x-api-key:`.
- `?token=`, `&token=`, `?api_key=`, `&api_key=`, `?password=`, `&password=`.
- 16-digit PAN-like sequences.
- SSN-like `XXX-XX-XXXX`.
- Embedded private-key markers (`BEGIN RSA PRIVATE KEY`, `BEGIN OPENSSH PRIVATE KEY`).
- Production-endpoint host names not on the approved allow-list (allow-list is currently empty; approval requires founder gate).
- Real customer identifiers, internal vendor account IDs, and full legal names tied to customers.

A failing match stops the run and routes per [validation/no-drift-rules.md](../validation/no-drift-rules.md).

## Check 11 — Sensitive-data confirmation

- `sensitive_data_confirmed_redacted` must equal `true` before any run begins.
- The template ships `false` so the operator is forced to confirm before execution.

## Check 12 — Expected baseline and scoring coupling

- `scoring_enabled == true` ⇒ `expected_baseline_required == true` AND `expected_root` non-empty.
- `expected_baseline_required == true` ⇒ `expected_root` non-empty.
- `expected_baseline_required == false` permits `expected_root` empty.

## Check 13 — Output write-boundary

- All run output writes must land under the resolved `output_root` (`runs/<run_id>/`).
- A write outside `output_root` is a critical miss enforced by Build Package 11.
- Build Package 02 declares the rule; later Build Packages enforce it operationally.

## Check 14 — No drift from schema

- Any field present in `runs/<run_id>/run-profile.yaml` but not declared in [config/run-profile.schema.yaml](run-profile.schema.yaml) fails validation. `additionalProperties` is `false` in the schema.
- Any later Build Package that introduces a new field without amending the schema in the same change set is drift, blocked by [validation/no-drift-rules.md](../validation/no-drift-rules.md).

## Validation order

Build Package 03 tools and Build Package 12 validators apply checks in this order so the operator gets the most informative first failure:

1. Required field presence (Check 1).
2. Type and enum validation (Check 2).
3. Identifier patterns (Check 3).
4. Path resolution (Check 4).
5. No drift from schema (Check 14).
6. Mode coupling (Checks 5, 6).
7. Output destination required URLs (Check 7).
8. Post-back honesty (Check 8).
9. Connector and MCP honesty (Check 9).
10. Expected baseline and scoring coupling (Check 12).
11. Sensitive-data validation (Check 10).
12. Sensitive-data confirmation (Check 11).
13. Output write-boundary (Check 13) — runtime check during writes, not a pre-run static check.
