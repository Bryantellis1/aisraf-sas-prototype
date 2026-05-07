# Build Package 02 — Config and Run-Profile Variable Model Checklist

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 02.
Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml)

This checklist is the acceptance gate for Build Package 02. Every item must read PASS before Build Package 03 (Tools and setup/test/export scripts) may begin. FAIL items must be resolved or recorded as explicit blockers.

## 1. File presence

| # | Check | Status | Evidence |
|---|---|---|---|
| 1.1 | `config/run-profile.schema.yaml` exists | PASS | [config/run-profile.schema.yaml](../config/run-profile.schema.yaml) |
| 1.2 | `config/run-profile.template.yaml` exists | PASS | [config/run-profile.template.yaml](../config/run-profile.template.yaml) |
| 1.3 | `config/run-profile.sample.folder-first.yaml` exists | PASS | [config/run-profile.sample.folder-first.yaml](../config/run-profile.sample.folder-first.yaml) |
| 1.4 | `config/run-profile.sample.integration.yaml` exists | PASS | [config/run-profile.sample.integration.yaml](../config/run-profile.sample.integration.yaml) |
| 1.5 | `config/run-profile.field-catalog.md` exists | PASS | [config/run-profile.field-catalog.md](../config/run-profile.field-catalog.md) |
| 1.6 | `config/run-profile.validation-rules.md` exists | PASS | [config/run-profile.validation-rules.md](../config/run-profile.validation-rules.md) |
| 1.7 | `config/path-resolution-rules.md` exists | PASS | [config/path-resolution-rules.md](../config/path-resolution-rules.md) |
| 1.8 | `config/integration-fields.md` exists | PASS | [config/integration-fields.md](../config/integration-fields.md) |
| 1.9 | `config/sensitive-data-rules.md` exists | PASS | [config/sensitive-data-rules.md](../config/sensitive-data-rules.md) |
| 1.10 | `validation/package-02-config-checklist.md` exists | PASS | this file |

## 2. Schema integrity

| # | Check | Status | Evidence |
|---|---|---|---|
| 2.1 | Schema declares 25 required fields plus optional `notes` | PASS | `required:` block in schema lists 25 fields; `notes` is in `properties` but not `required` |
| 2.2 | `additionalProperties: false` set | PASS | top of schema |
| 2.3 | `schema_version` is `const: run_profile.v0_1_2` | PASS | schema property block |
| 2.4 | `package_version` is `const: v0.1.2` | PASS | schema property block |
| 2.5 | `mode` enum lists exactly six values | PASS | `folder_first_test`, `folder_first_review`, `integration_assisted_intake`, `integration_assisted_postback`, `dry_run_revalidation`, `live_reviewer_run` |
| 2.6 | `output_destination_mode` enum lists exactly five values | PASS | `local_only`, `jira_draft`, `confluence_draft`, `jira_and_confluence_draft`, `external_postback_executed` |
| 2.7 | `postback_execution_status` enum lists exactly four values | PASS | `deferred`, `formatted_only`, `executed_by_operator`, `not_attempted` |
| 2.8 | Connector status enums list exactly five values each | PASS | `not_required`, `unavailable`, `configured_not_tested`, `available`, `executed_by_operator` |
| 2.9 | `mcp_execution_status` enum lists exactly four values | PASS | `not_required`, `unavailable`, `configured_not_tested`, `executed_by_operator` |
| 2.10 | Conditional `allOf` rules pin folder-first family to safe defaults | PASS | rules for `folder_first_test`, `folder_first_review`, `dry_run_revalidation` all set `output_destination_mode: local_only`, `postback_execution_status: deferred`, connectors to `not_required`/`unavailable` |
| 2.11 | Conditional `allOf` rule couples `external_postback_executed` to `executed_by_operator` and at least one URL | PASS | dedicated `if/then/anyOf` block |
| 2.12 | Inverse rule: `executed_by_operator` requires `external_postback_executed` | PASS | dedicated `if/then` block |
| 2.13 | Conditional rule: `scoring_enabled: true` requires `expected_baseline_required: true` and non-empty `expected_root` | PASS | dedicated `if/then` block |
| 2.14 | `sensitive_data_confirmed_redacted` must be `true` in a valid profile | PASS | top-level `properties.const: true` rule in `allOf` |

## 3. Template / sample alignment

| # | Check | Status | Evidence |
|---|---|---|---|
| 3.1 | Template carries every required schema field | PASS | template sections match 25 required + 1 optional |
| 3.2 | Template ships `sensitive_data_confirmed_redacted: false` so operator must flip explicitly | PASS | template line in safety-and-scoring block |
| 3.3 | Folder-first sample uses `mode: folder_first_test`, `output_destination_mode: local_only`, `postback_execution_status: deferred`, all connectors `not_required`, `rovo_mcp_available: false`, `mcp_execution_status: not_required` | PASS | [config/run-profile.sample.folder-first.yaml](../config/run-profile.sample.folder-first.yaml) |
| 3.4 | Integration sample uses `mode: integration_assisted_intake`, honest connector posture (no false `available`/`executed_by_operator` claims), `postback_execution_status: deferred` | PASS | [config/run-profile.sample.integration.yaml](../config/run-profile.sample.integration.yaml) |
| 3.5 | Both samples use placeholder run identifiers (`RUN-SAMPLE-FOLDER-FIRST`, `RUN-SAMPLE-INTEGRATION`) that satisfy the run_id pattern | PASS | both files |
| 3.6 | Integration sample URL is a synthetic `example.atlassian.net` placeholder, not a production endpoint | PASS | [config/run-profile.sample.integration.yaml](../config/run-profile.sample.integration.yaml) |

## 4. Field catalog coverage

| # | Check | Status | Evidence |
|---|---|---|---|
| 4.1 | Field catalog covers every schema property | PASS | [config/run-profile.field-catalog.md](../config/run-profile.field-catalog.md) lists 26 fields (25 required + `notes`) |
| 4.2 | Each catalog row records type, allowed values, default, edited-by, derived, used-by Build Packages, sensitivity, example | PASS | every row in the catalog carries the eight attributes |
| 4.3 | Every catalog row references at least one downstream Build Package | PASS | "used by" column references Build Packages 02–16 |
| 4.4 | Catalog field-coverage cross-check section confirms 1:1 match with schema | PASS | catalog § "Field coverage cross-check" |

## 5. Path resolution rules

| # | Check | Status | Evidence |
|---|---|---|---|
| 5.1 | Path-resolution doc declares `workspace_root` resolution | PASS | [config/path-resolution-rules.md](../config/path-resolution-rules.md) § 1 |
| 5.2 | Doc lists allowed and disallowed path forms | PASS | § 3 |
| 5.3 | Doc declares output write-boundary (writes only under `output_root`) | PASS | § 4 |
| 5.4 | Doc declares read-boundary (reads only from `input_root` and `expected_root`) | PASS | § 5 |
| 5.5 | Doc gives Windows path examples | PASS | § 6 |
| 5.6 | Doc declares no-hardcoded-paths rule for later Build Packages | PASS | § 7 |
| 5.7 | Doc forbids writes to `old_reference_workspace` | PASS | § 1 |

## 6. Integration fields honesty

| # | Check | Status | Evidence |
|---|---|---|---|
| 6.1 | Integration-fields doc declares the `output_destination_mode` × `postback_execution_status` matrix | PASS | [config/integration-fields.md](../config/integration-fields.md) § 2 |
| 6.2 | Doc declares connector status semantics with explicit "claim requires evidence" | PASS | § 3 |
| 6.3 | Doc separates Rovo MCP availability from MCP execution | PASS | § 4 |
| 6.4 | Doc declares the no-claim-without-evidence rule (§ 5) | PASS | § 5 |
| 6.5 | Doc declares folder-first as honest about what it does and does not do | PASS | § 6 |
| 6.6 | Doc declares URL hygiene rules | PASS | § 7 |

## 7. Sensitive-data rules

| # | Check | Status | Evidence |
|---|---|---|---|
| 7.1 | Sensitive-data doc lists categorically prohibited content | PASS | [config/sensitive-data-rules.md](../config/sensitive-data-rules.md) § 1 |
| 7.2 | Doc declares URL hygiene rules | PASS | § 2 |
| 7.3 | Doc lists prohibited substrings (lint targets) | PASS | § 3 |
| 7.4 | Doc lists prohibited regex patterns | PASS | § 4 |
| 7.5 | Doc declares operator/reviewer identity field rules | PASS | § 5 |
| 7.6 | Doc declares notes field rule | PASS | § 6 |
| 7.7 | Doc declares sample-input rule | PASS | § 7 |
| 7.8 | Doc declares the `sensitive_data_confirmed_redacted` confirmation gate | PASS | § 8 |
| 7.9 | Doc declares incident response when violation is detected | PASS | § 9 |

## 8. Build Package 02 prohibitions (no scope creep)

| # | Check | Status | Evidence |
|---|---|---|---|
| 8.1 | No tools or scripts created (no files under `tools/` beyond the existing README) | PASS | `tools/` contains only `README.md` |
| 8.2 | No prompt cards created (no files under `prompts/` beyond the existing README) | PASS | `prompts/` contains only `README.md` |
| 8.3 | No skill contracts created (no files under `skills/` beyond the existing README) | PASS | `skills/` contains only `README.md` |
| 8.4 | No PRA specs created (no files under `prototype-agents/` beyond the existing README) | PASS | `prototype-agents/` contains only `README.md` |
| 8.5 | No `.agent.md` adapters created (no files under `.agents/` beyond the existing README) | PASS | `.agents/` contains only `README.md` |
| 8.6 | No catalogs created (no files under `catalogs/` beyond the existing README) | PASS | `catalogs/` contains only `README.md` |
| 8.7 | No blueprints created (no files under `blueprints/` beyond the existing README) | PASS | `blueprints/` contains only `README.md` |
| 8.8 | No samples or expected baselines created (no files under `samples/` beyond the existing README) | PASS | `samples/` contains only `README.md` |
| 8.9 | No run outputs created (no files under `runs/` beyond the existing README) | PASS | `runs/` contains only `README.md` |
| 8.10 | No diagrams created (no files under `diagrams/` beyond the existing README) | PASS | `diagrams/` contains only `README.md` |
| 8.11 | No release artifacts created (no files under `release/` beyond the existing README) | PASS | `release/` contains only `README.md` |
| 8.12 | No docs/runbooks created (no files under `docs/` beyond the existing README) | PASS | `docs/` contains only `README.md` |
| 8.13 | No templates created beyond authoring-agent templates from Build Package 01 | PASS | `templates/` contains only `README.md` |
| 8.14 | No schemas created outside `config/` | PASS | only `config/run-profile.schema.yaml` exists; no schemas under `samples/`, `runs/`, `validation/`, etc. |
| 8.15 | No runtime code, cloud assets, MCP/Jira/Confluence proof, or release binaries created | PASS | none added in this Build Package |

## 9. Old reference workspace untouched

| # | Check | Status | Evidence |
|---|---|---|---|
| 9.1 | No file in `D:\E-Way 2\aisraf-sas-prototype-skill-chain-pack-v0.01` was modified by Build Package 02 | PASS | Build Package 02 wrote only inside the active workspace `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2` |
| 9.2 | The `old_reference_workspace` field is honest read-only context only | PASS | every reference to the old workspace is read-only |

## 10. Governance updates

| # | Check | Status | Evidence |
|---|---|---|---|
| 10.1 | `config/README.md` points to the 9 new config files and confirms Build Package 02 status | PASS | [config/README.md](../config/README.md) |
| 10.2 | `PACKAGE-MANIFEST.yaml` records `current_build_package: "02"` and `next_build_package: "03"` | PASS | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) |
| 10.3 | `PACKAGE-MANIFEST.yaml` declares a `build_package_02_allowed_writes` block listing the 10 new files plus governance updates | PASS | manifest block |
| 10.4 | `validation/no-drift-rules.md` adds the rule "no Build Package may invent run-profile fields outside `config/run-profile.schema.yaml`" | PASS | [validation/no-drift-rules.md](no-drift-rules.md) |
| 10.5 | `BUILD-ORDER.md` Build Package 02 entry remains accurate after this Build Package activates | PASS | [BUILD-ORDER.md](../BUILD-ORDER.md) Build Package 02 entry already references the run-profile variable model |
| 10.6 | `FOLDER-CONTRACTS.md` Root Area 04 entry remains accurate | PASS | [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md) Root Area 04 already permits Build Package 02 writes |

## 11. Next allowed Build Package

| # | Check | Status | Evidence |
|---|---|---|---|
| 11.1 | Next allowed Build Package is Build Package 03 — Tools and setup/test/export scripts | PASS | manifest `next_build_package.build_package_number: "03"` |
| 11.2 | Build Package 03 has a stable variable contract to build against | PASS | run-profile schema, template, samples, field catalog, validation rules, path resolution, integration fields, and sensitive-data rules are all in place |

## Verdict

**Build Package 02 acceptance: PASS** — all items above PASS. The config and run-profile variable model is ready for Build Package 03 to consume.

## Out-of-scope (do not verify here)

- Tools and setup helper scripts (Build Package 03).
- Prompt cards (Build Package 04).
- Skill contracts (Build Package 05).
- PRA specs and `.agent.md` adapter model (Build Package 06).
- Catalogs (Build Package 07).
- Blueprints (Build Package 08).
- Templates beyond Build Package 01 authoring-agent templates (Build Package 09).
- Samples and expected baselines (Build Package 10).
- Run outputs and execution evidence (Build Package 11).
- Full validation model (Build Package 12).
- Diagrams (Build Package 13).
- Practitioner documentation and runbooks (Build Package 14).
- Release packaging (Build Package 15).
- Final QA, seal, export (Build Package 16).
