# Run Profile Field Catalog

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 02 — Config and run-profile variable model.
Schema authority: [config/run-profile.schema.yaml](run-profile.schema.yaml)

This catalog documents every field declared in the run-profile schema. For each field it records type, allowed values, default, who edits it, whether it is derived, which Build Packages consume it, sensitivity rules, and an example. Field order matches the schema.

Legend:

- Edited by: who fills the value. `operator` = human operator. `tool` = Build Package 03 setup helper. `constant` = template-pinned, not edited.
- Derived: `yes` if the value can be computed from other fields rather than independently chosen.
- Sensitivity: `low` (no operational risk), `medium` (URL-shaped, must be sanitised of credentials), `high` (must never carry secrets, PII, PAN, SSN, customer payload, or production endpoints unless approved).

## 1. Identity

### `schema_version`

| attribute | value |
|---|---|
| required | yes |
| type | string (constant) |
| allowed values | `run_profile.v0_1_2` |
| default | `run_profile.v0_1_2` |
| edited by | constant |
| derived | no |
| used by | Build Package 02 (this schema), Build Package 03 (tool reads to validate version), Build Package 12 (validation), all later Build Packages that resolve `{{run-profile}}` |
| sensitivity | low |
| example | `run_profile.v0_1_2` |

### `package_version`

| attribute | value |
|---|---|
| required | yes |
| type | string (constant) |
| allowed values | `v0.1.2` |
| default | `v0.1.2` |
| edited by | constant |
| derived | no |
| used by | every Build Package that reads run-profile |
| sensitivity | low |
| example | `v0.1.2` |

### `run_id`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | matches `^RUN-[A-Z0-9][A-Z0-9-]*$`, length 5–64 |
| default | none — operator or tool sets per run |
| edited by | operator (or tool when invoked with `-RunId`) |
| derived | no |
| used by | Build Packages 03–16; resolves `{{run_id}}` and the `runs/<run_id>/` folder name |
| sensitivity | high (must not encode customer identifiers) |
| example | `RUN-001`, `RUN-LOCAL-20260506` |

### `sample_id`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | matches `^sample-[0-9]{3}[a-z0-9-]*$`, length 11–64 |
| default | `sample-001-dfd-crop` |
| edited by | operator |
| derived | no |
| used by | Build Packages 04, 05, 06, 09, 10, 11, 12; resolves `{{sample_id}}` |
| sensitivity | high (must not encode customer identifiers) |
| example | `sample-001-dfd-crop` |

## 2. Mode

### `mode`

| attribute | value |
|---|---|
| required | yes |
| type | string (enum) |
| allowed values | `folder_first_test`, `folder_first_review`, `integration_assisted_intake`, `integration_assisted_postback`, `dry_run_revalidation`, `live_reviewer_run` |
| default | `folder_first_test` |
| edited by | operator |
| derived | no |
| used by | every later Build Package that branches behaviour by run posture |
| sensitivity | low |
| example | `folder_first_test` |

Mode coupling rules (see [config/run-profile.validation-rules.md](run-profile.validation-rules.md)):

- `folder_first_test`, `folder_first_review`, `dry_run_revalidation` ⇒ integration surface is empty and connectors are `not_required` or `unavailable`.
- `integration_assisted_intake`, `integration_assisted_postback` ⇒ URLs may be set; post-back stays `deferred` unless a human operator records execution evidence.
- `live_reviewer_run` ⇒ operator declares connector posture honestly; no defaults are forced.

## 3. Path roots

### `workspace_root`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | relative path; default `.` |
| default | `.` |
| edited by | constant |
| derived | no |
| used by | Build Packages 03–16; root for relative-path resolution |
| sensitivity | low |
| example | `.` |

### `input_root`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | relative path, no `..`, no drive letter, no leading `/` |
| default | `runs/<run_id>/inputs` (set by tool) |
| edited by | tool (Build Package 03); operator may override for custom intake |
| derived | yes (from `run_id` for sample runs) |
| used by | Build Packages 04, 05, 06, 11 |
| sensitivity | high |
| example | `runs/RUN-001/inputs` |

### `expected_root`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | relative path; may be empty when `expected_baseline_required: false` |
| default | `samples/<sample_id>/expected` |
| edited by | tool; operator may override |
| derived | yes (from `sample_id`) |
| used by | Build Packages 10, 11, 12 |
| sensitivity | high |
| example | `samples/sample-001-dfd-crop/expected` |

### `output_root`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | matches `^runs/RUN-[A-Z0-9][A-Z0-9-]*(/.*)?$` |
| default | `runs/<run_id>` |
| edited by | tool |
| derived | yes (from `run_id`) |
| used by | every Build Package that writes run output (especially 11) |
| sensitivity | high |
| example | `runs/RUN-001` |

### `old_reference_workspace`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | absolute path to the v0.01 reference workspace |
| default | `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` |
| edited by | constant |
| derived | no |
| used by | Build Packages 02 (this catalog), 12 (validation, no-write rule), 14 (docs cross-references) |
| sensitivity | low |
| example | `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` |

## 4. Source / destination references

### `source_ticket_url`

| attribute | value |
|---|---|
| required | yes (string field; may be empty) |
| type | string |
| allowed values | empty string or `https://<host>/<path>` URL with no query string |
| default | `""` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11 (run log), 14 (docs) |
| sensitivity | high (URL only — no tokens, no query credentials) |
| example | `https://example.atlassian.net/browse/SAS-123` |

### `destination_ticket_url`

| attribute | value |
|---|---|
| required | yes (string field; may be empty) |
| type | string |
| allowed values | empty string or `https://<host>/<path>` URL with no query string |
| default | `""` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11, 14 |
| sensitivity | high |
| example | `https://example.atlassian.net/browse/SAS-456` |

### `destination_confluence_url`

| attribute | value |
|---|---|
| required | yes (string field; may be empty) |
| type | string |
| allowed values | empty string or `https://<host>/<path>` URL with no query string |
| default | `""` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11, 14 |
| sensitivity | high |
| example | `https://example.atlassian.net/wiki/spaces/SAS/pages/789` |

## 5. Connector and post-back posture

### `output_destination_mode`

| attribute | value |
|---|---|
| required | yes |
| type | string (enum) |
| allowed values | `local_only`, `jira_draft`, `confluence_draft`, `jira_and_confluence_draft`, `external_postback_executed` |
| default | `local_only` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 09, 11, 14 |
| sensitivity | low |
| example | `local_only` |

### `postback_execution_status`

| attribute | value |
|---|---|
| required | yes |
| type | string (enum) |
| allowed values | `deferred`, `formatted_only`, `executed_by_operator`, `not_attempted` |
| default | `deferred` |
| edited by | operator after delivery |
| derived | no |
| used by | Build Packages 11 (run log), 12 (validation) |
| sensitivity | low |
| example | `deferred` |

Hard rule: no later artifact may claim post-back execution unless this field is `executed_by_operator` AND `output_root/00-run-log.md` records timestamp, destination URL, and operator role. See [config/integration-fields.md](integration-fields.md) and [validation/no-drift-rules.md](../validation/no-drift-rules.md).

### `jira_connector_status`

| attribute | value |
|---|---|
| required | yes |
| type | string (enum) |
| allowed values | `not_required`, `unavailable`, `configured_not_tested`, `available`, `executed_by_operator` |
| default | `not_required` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11, 12 |
| sensitivity | low |
| example | `not_required` |

### `confluence_connector_status`

| attribute | value |
|---|---|
| required | yes |
| type | string (enum) |
| allowed values | `not_required`, `unavailable`, `configured_not_tested`, `available`, `executed_by_operator` |
| default | `not_required` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11, 12 |
| sensitivity | low |
| example | `not_required` |

### `rovo_mcp_available`

| attribute | value |
|---|---|
| required | yes |
| type | boolean |
| allowed values | `true`, `false` |
| default | `false` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11, 12 |
| sensitivity | low |
| example | `false` |

### `mcp_execution_status`

| attribute | value |
|---|---|
| required | yes |
| type | string (enum) |
| allowed values | `not_required`, `unavailable`, `configured_not_tested`, `executed_by_operator` |
| default | `not_required` |
| edited by | operator |
| derived | no |
| used by | Build Packages 06, 11, 12 |
| sensitivity | low |
| example | `not_required` |

## 6. Operator and reviewer identity

### `operator_name`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | length 1–80; role label or short display name |
| default | `SAS reviewer` |
| edited by | operator |
| derived | no |
| used by | Build Packages 11 (run log), 12 (validation) |
| sensitivity | high (no PII, no full legal names tied to real customers) |
| example | `SAS reviewer` |

### `reviewer_name`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | length 1–80; role label or short display name |
| default | `SAS reviewer` |
| edited by | operator |
| derived | no |
| used by | Build Packages 11, 12 |
| sensitivity | high |
| example | `AppSec reviewer` |

## 7. Safety and scoring flags

### `sensitive_data_confirmed_redacted`

| attribute | value |
|---|---|
| required | yes |
| type | boolean |
| allowed values | must be `true` for a valid run profile at execution time |
| default | template ships `false`; operator must flip to `true` |
| edited by | operator |
| derived | no |
| used by | Build Package 03 (tool gate), 11, 12 |
| sensitivity | low |
| example | `true` |

### `expected_baseline_required`

| attribute | value |
|---|---|
| required | yes |
| type | boolean |
| allowed values | `true`, `false` |
| default | `true` |
| edited by | operator |
| derived | no |
| used by | Build Packages 11, 12 |
| sensitivity | low |
| example | `true` |

### `scoring_enabled`

| attribute | value |
|---|---|
| required | yes |
| type | boolean |
| allowed values | `true`, `false`; when `true`, `expected_baseline_required` must be `true` and `expected_root` non-empty |
| default | `true` |
| edited by | operator |
| derived | no |
| used by | Build Packages 11, 12 |
| sensitivity | low |
| example | `true` |

## 8. Metadata

### `created_at`

| attribute | value |
|---|---|
| required | yes |
| type | string |
| allowed values | matches `^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$` (ISO 8601 UTC) |
| default | written by Build Package 03 tool |
| edited by | tool |
| derived | yes (current UTC at run-folder creation) |
| used by | Build Packages 11, 12, 14 |
| sensitivity | low |
| example | `2026-05-06T12:00:00Z` |

### `notes`

| attribute | value |
|---|---|
| required | no (defaults to empty string) |
| type | string |
| allowed values | length 0–4096 |
| default | `""` |
| edited by | operator |
| derived | no |
| used by | Build Packages 11, 14 |
| sensitivity | high (free text — sensitive-data prohibition applies) |
| example | `Folder-first sample profile.` |

## Field coverage cross-check

The 26 fields above (25 required + 1 optional `notes`) match every property declared in [config/run-profile.schema.yaml](run-profile.schema.yaml). Adding, removing, or renaming a field in this catalog without a matching change to the schema in the same change set is drift. See [validation/no-drift-rules.md](../validation/no-drift-rules.md).
