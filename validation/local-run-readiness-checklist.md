# Local Run Readiness Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: confirms an operator can execute `runs/RUN-001/` end-to-end against the BP04–BP09 chain locally without inventing files, agents, or paths. The checklist is read-only and does not execute the chain.

`BP12-SAMPLE-DFD-BLOCKER` is recorded here as a precondition warning: local execution will produce outputs that mirror an input-quality defect; operators should expect downgraded confidence and `unknown` markers in resulting outputs.

## Identity

- Gate category: Run gate.
- Run order position: 5 (Run gates).
- Run fixture: `runs/RUN-001/` (sealed).
- Activation: operator-driven; Build Package 12 does not execute the chain.

## Precondition Warning — BP12-SAMPLE-DFD-BLOCKER

The canonical sample DFD inherited by `runs/RUN-001/inputs/dfd-crop.png` carries founder-identified defects (see `validation/sample-input-readiness-checklist.md`). Local execution will succeed mechanically but the resulting outputs are NOT a canonical reference run. Operators should:

- Expect downgraded confidence on flow / boundary / storage-annotation fields.
- Expect `unknown` markers in DFD subskill outputs.
- Treat the resulting numeric accuracy score (if any) as "framework-shake" evidence, not as v0.1.2 canonical truth.
- Withhold sealing the run as canonical until founder-approved Package 10A / 11A correction or sample-002 with a clean DFD lands.

## Scope

- `runs/RUN-001/run-profile.yaml` placeholder resolution.
- On-disk references from the run profile (input root, expected root, output root).
- Output destination conformance (`local_only`).
- Read-only verification that the BP04 prompt cards, BP05 skill contracts, BP06 PRA specs, and BP06 `.agent.md` adapters reference paths that resolve under the active workspace.

## Inputs

- `runs/RUN-001/run-profile.yaml` (sealed; BP02 schema-compliant).
- `runs/RUN-001/00-run-log.md` (sealed; BP09 file-shape-compliant; Step Entries / Post-Back Evidence / Stop Conditions Recorded sections empty).
- `runs/RUN-001/README.md` (sealed).
- `runs/RUN-001/inputs/*` (6 byte-copies; sealed).
- `runs/RUN-001/dfd/.gitkeep` (BP12 fresh-clone reservation marker).
- `samples/sample-001-dfd-crop/expected/*` (26 baselines; sealed).
- `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/` (all sealed).

## Gates

### Run-profile placeholder resolution

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | Schema version | `run-profile.yaml#schema_version: run_profile.v0_1_2`. | PASS |
| 2 | `run_id` | `RUN-001`. | PASS |
| 3 | `sample_id` | `sample-001-dfd-crop`. | PASS |
| 4 | `mode` | `folder_first_test`. | PASS |
| 5 | `input_root` | `runs/RUN-001/inputs` (forward-slash, no drive letter). | PASS |
| 6 | `expected_root` | `samples/sample-001-dfd-crop/expected` (forward-slash, no drive letter). | PASS |
| 7 | `output_root` | `runs/RUN-001` (forward-slash, no drive letter, no `..`). | PASS |
| 8 | `output_destination_mode` | `local_only`. | PASS |
| 9 | `postback_execution_status` | `deferred`. | PASS |
| 10 | `expected_baseline_required` | `true`. | PASS |
| 11 | `scoring_enabled` | `true`. | PASS |
| 12 | `sensitive_data_confirmed_redacted` | `true` (synthetic). | PASS |

### On-disk reference integrity

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 13 | `input_root` resolves | `runs/RUN-001/inputs/` exists with 6 byte-copies. | PASS |
| 14 | `expected_root` resolves | `samples/sample-001-dfd-crop/expected/` exists with 26 Markdown baselines. | PASS |
| 15 | `output_root` resolves | `runs/RUN-001/` exists; the chain writes 17 RS outputs at the root and 9 DFD outputs under `dfd/` when run. | PASS |
| 16 | DFD reservation marker present | `runs/RUN-001/dfd/.gitkeep` exists; Build Package 12 ensures the empty governed folder survives `git clone`. | PASS |
| 17 | Run log shape valid | `runs/RUN-001/00-run-log.md` mirrors `templates/output/output-00-run-log-template.md` and uses only the 7 approved placeholders. | PASS |

### Output destination conformance

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 18 | No external destination configured | `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url` are empty. | PASS |
| 19 | No connector activation | `jira_connector_status`, `confluence_connector_status`, `mcp_execution_status` are all `not_required`. | PASS |
| 20 | Rovo / MCP not available | `rovo_mcp_available: false`. | PASS |
| 21 | Local-only writes | The chain (when executed) writes only under `{{output_root}}` (= `runs/RUN-001/`). | PASS |

### Chain artefact reference resolution

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 22 | 23 prompt cards reachable | The 23 BP04 prompt cards under `prompts/rs/` and `prompts/dfd/` resolve on disk. | PASS |
| 23 | 26 skill contracts reachable | The 26 BP05 skill contracts under `skills/rs/` and `skills/dfd/` resolve on disk. | PASS |
| 24 | 8 PRA specs reachable | The 8 BP06 PRA specs under `prototype-agents/PRA-0[1-8]-*.md` resolve on disk. | PASS |
| 25 | 7 adapters reachable | The 7 BP06 `.agent.md` adapters under `.agents/aisraf-*.agent.md` resolve on disk. | PASS |
| 26 | Catalog dependencies reachable | Every catalog cited by the chain (via `catalogs/catalog-registry.yaml`) resolves on disk. | PASS |
| 27 | Blueprint dependencies reachable | Every blueprint cited by the chain (via `blueprints/blueprint-registry.yaml`) resolves on disk. | PASS |
| 28 | Template dependencies reachable | Every template cited by the chain (via `templates/template-registry.yaml`) resolves on disk. | PASS |

### No mid-run discoveries

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 29 | No invented file paths | The run profile and the chain do not require an operator to create any file outside the BP12 allow-list. | PASS |
| 30 | No invented agent names | The chain does not reference any agent outside the 7 BP06 adapters and 8 PRAs. | PASS |
| 31 | No invented run-profile fields | The run profile uses only fields defined in `config/run-profile.schema.yaml`. | PASS |
| 32 | No invented placeholders | The run profile and the chain do not introduce non-schema placeholders (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`). | PASS |

### Tool readiness

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 33 | `tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` returns 12 PASS / 0 FAIL. | exit 0 | PASS |
| 34 | `tools/Test-AisrafPackage.ps1` returns 0 FAIL after BP12 patches. | exit 0 | PASS |
| 35 | `tools/New-AisrafRun.ps1` does not need to run for RUN-001 (RUN-001 was hand-built per BP11 founder decision Q7). | not required | PASS |

## Acceptance Verdict

- **PASS** when every gate reads PASS — the operator can execute the chain locally without inventing files or paths.
- **PARTIAL_WITH_ISSUES** when one or more reference resolution gates surface a missing optional dependency that is documented as future-only.
- **FAIL** when any required path, registry entry, or schema field is missing.

The `BP12-SAMPLE-DFD-BLOCKER` precondition warning does NOT cause this checklist to FAIL — local execution remains possible. The blocker downgrades confidence on chain outputs and prevents the run from being sealed as canonical.

## Stop Conditions

- A required file or registry entry is missing.
- The run profile fails schema validation.
- The chain references an artefact path that does not resolve on disk.

## Tool References

- `tools/Test-AisrafRunProfile.ps1` — schema validation of the run profile.
- `tools/Test-AisrafPackage.ps1` — surface validation of the workspace.

## Out-of-Scope

- Executing the BP04–BP09 chain.
- Producing any of the 17 RS or 9 DFD chain outputs.
- Sealing `runs/RUN-001/` as canonical (blocked by `BP12-SAMPLE-DFD-BLOCKER`).
