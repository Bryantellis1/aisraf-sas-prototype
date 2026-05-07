# Integration Fields

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 02.
Schema authority: [config/run-profile.schema.yaml](run-profile.schema.yaml)

This document explains the optional Jira, Confluence, Rovo, and MCP fields in the run profile. Folder-first execution is the default and works without any of these fields populated. Integration fields are honest metadata only; they do not prove that an external system was actually read or written.

## 1. Field summary

| field | type | purpose |
|---|---|---|
| `source_ticket_url` | URL | Jira ticket the operator pulled inputs from. Empty in folder-first modes. |
| `destination_ticket_url` | URL | Jira ticket where outputs are intended to be posted. |
| `destination_confluence_url` | URL | Confluence page where outputs are intended to be published. |
| `output_destination_mode` | enum | Declares delivery INTENT only. Does not prove execution. |
| `postback_execution_status` | enum | Declares actual human execution state. |
| `jira_connector_status` | enum | Posture of the Jira connector for this run. |
| `confluence_connector_status` | enum | Posture of the Confluence connector for this run. |
| `rovo_mcp_available` | boolean | True only when Atlassian Rovo MCP is actually available. |
| `mcp_execution_status` | enum | Posture of MCP-assisted execution for this run. |

## 2. `output_destination_mode` × `postback_execution_status` matrix

| `output_destination_mode` | required URLs | typical `postback_execution_status` |
|---|---|---|
| `local_only` | none | `deferred`, `not_attempted` |
| `jira_draft` | `destination_ticket_url` | `deferred`, `formatted_only` |
| `confluence_draft` | `destination_confluence_url` | `deferred`, `formatted_only` |
| `jira_and_confluence_draft` | both | `deferred`, `formatted_only` |
| `external_postback_executed` | at least one of the two | `executed_by_operator` (required) |

The schema enforces:

- `output_destination_mode == external_postback_executed` ⇒ `postback_execution_status == executed_by_operator`.
- `postback_execution_status == executed_by_operator` ⇒ `output_destination_mode == external_postback_executed`.

See [config/run-profile.validation-rules.md](run-profile.validation-rules.md) Checks 7 and 8.

## 3. Connector status semantics

| value | meaning |
|---|---|
| `not_required` | The run does not need this connector. Folder-first default. |
| `unavailable` | The connector is not installed or not accessible in this environment. |
| `configured_not_tested` | The connector is set up locally but no read or write through it has been performed for this run. |
| `available` | The connector is installed and a read or write has been performed in a prior session, but not for this run. |
| `executed_by_operator` | The operator actually performed a read or write through the connector for this run AND recorded evidence in `output_root/00-run-log.md` (Build Package 11 enforces). |

Honest postures only. Claiming `available` or `executed_by_operator` without evidence is a critical miss.

## 4. Rovo MCP and MCP execution

`rovo_mcp_available` is a per-environment boolean. Set it to `true` only when:

- Atlassian Rovo MCP is installed and authenticated for the operator's account.
- The operator can read at least one Jira ticket or Confluence page through Rovo MCP at the time the run profile is created.
- The operator records the availability evidence in the run log when integration modes are active.

`mcp_execution_status` records what actually happened during the run:

| value | meaning |
|---|---|
| `not_required` | The run does not use MCP. |
| `unavailable` | MCP is not available in this environment. |
| `configured_not_tested` | MCP is configured but no MCP-assisted action was executed for this run. |
| `executed_by_operator` | The operator performed an MCP-assisted action for this run AND recorded evidence in the run log. |

Atlassian for VS Code is a developer extension. It is NOT proof that Rovo MCP is connected.

## 5. Evidence required before claiming execution

No artifact, prompt, skill, PRA, runbook, scoring report, manifest entry, evidence record, diagram, or message may state that:

- A Jira ticket was posted.
- A Jira ticket was attached to.
- A Confluence page was published.
- An MCP action was performed.
- A connector was used to read or write.

…unless ALL of the following are true:

1. The corresponding `*_execution_status` (post-back, connector, or MCP) is `executed_by_operator`.
2. `output_root/00-run-log.md` records, for that action: ISO 8601 timestamp, destination URL or MCP target, operator role, and a short description.
3. The run log entry is dated within the run window.

Build Package 02 declares the rule. Build Package 11 wires the run-log enforcement. Build Package 12 lints for false claims. Build Package 14 documentation must follow the same rule.

## 6. Folder-first is honest

A folder-first run is honest about what it does and does not do:

- It reads only from `input_root`.
- It writes only to `output_root`.
- It does not call Jira, Confluence, Rovo, or MCP.
- Connector statuses are `not_required` or `unavailable`.
- Post-back stays `deferred`.

Folder-first is the default contract for sample-001 testing, dry-run revalidation, and any run where external connectivity is not available or not desired. A failing folder-first run cannot be hidden by claiming an integration step succeeded — there is no integration step to claim.

## 7. URL hygiene

URLs in `source_ticket_url`, `destination_ticket_url`, and `destination_confluence_url`:

- Must use `https://` scheme.
- Must not contain query strings carrying tokens, passwords, or session identifiers.
- Must not contain fragments carrying credentials.
- Must use canonical hostnames; private IP addresses and `localhost` URLs are rejected.

The schema regex enforces the basic shape; the sensitive-data lint in [config/sensitive-data-rules.md](sensitive-data-rules.md) catches embedded credentials.

## 8. Live run posture

`mode == live_reviewer_run` is intentionally permissive. Founder/SAS reviewer live runs may use any combination of connectors with honest status. The rules above still apply: no claim without evidence, no secrets in URLs, and the post-back honesty rule (§ 5) is non-negotiable.
