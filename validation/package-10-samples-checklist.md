# Build Package 10 — Samples Acceptance Checklist

Authored by: BUILD-AG-10-SAMPLES-R1.

Scope: confirms the Build Package 10 surface for AISRAF SAS Prototype v0.1.2.

## 1. Surface Inventory

| # | Check | Expected | Status |
|---|---|---|---|
| 1 | `samples/README.md` overwritten with the v0.1.2 sample-family description. | present and active | PASS |
| 2 | `samples/sample-registry.yaml` present with `registry_id: aisraf-sample-registry`, `schema_version: aisraf_sample_registry.v0_1_2`, `owning_build_package: Build Package 10`, `status: active`. | present | PASS |
| 3 | `samples/sample-001-dfd-crop/README.md` present and documents the practical application scenario. | present | PASS |
| 4 | `samples/sample-001-dfd-crop/inputs/` contains exactly 6 files: `dfd-crop.png`, `dfd-crop.mmd`, `dfd-legend-excerpt.md`, `cloud-triage-notes.md`, `review-transcript.md`, `intake-ticket.md`. | 6 files | PASS |
| 5 | `samples/sample-001-dfd-crop/expected/` contains 17 RS Markdown baselines (`expected-01-..expected-17-*.md`). | 17 files | PASS |
| 6 | `samples/sample-001-dfd-crop/expected/` contains 9 DFD Markdown baselines (`expected-dfd-01-..expected-dfd-09-*.md`). | 9 files | PASS |
| 7 | Total expected baselines under `samples/sample-001-dfd-crop/expected/` = 26. | 26 files | PASS |
| 8 | `expected-00-run-log.md` is **not** present in `samples/sample-001-dfd-crop/expected/`. Run logs are run artefacts; deferred to Build Package 11. | absent | PASS |
| 9 | All expected baselines are Markdown only. No `*.json` files appear in `samples/`. | Markdown-only | PASS |
| 10 | No additional sample folders are created. `samples/sample-002-*` through `samples/sample-008-*` exist only in `samples/sample-registry.yaml#planned_or_deferred_samples`. | registry-only entries | PASS |

## 2. Practical Application Scenario

| # | Check | Status |
|---|---|---|
| 11 | sample-001 scenario is documented in `samples/sample-001-dfd-crop/README.md` § 1 as "AI SaaS Security Review Portal". | PASS |
| 12 | Component count is within the 5–10 target band (8 components). | PASS |
| 13 | Flow count is within the 6–10 target band (8 flows). | PASS |
| 14 | Trust-boundary count is within the 2–4 target band (4 boundaries). | PASS |
| 15 | Data-store count is within the 2–3 target band (3 data stores). | PASS |
| 16 | At least one external system is present (CMP-05). | PASS |
| 17 | At least one model/AI endpoint is present (CMP-05). | PASS |
| 18 | At least one human actor is present (CMP-01). | PASS |
| 19 | At least one optional Jira/Confluence draft destination is present (CMP-08, `formatted_only`). | PASS |
| 20 | At least one unknown/ambiguous annotation is present (F4 / F5 `class unknown`). | PASS |
| 21 | At least one proof-vs-signal test is present (`S1` diamond at CMP-03). | PASS |
| 22 | At least one boundary crossing is present (BC-01 internet → application; plus 6 others). | PASS |
| 23 | At least one AuthN/AuthZ uncertainty is present (`SA1` AuthN at F4 with `AZ-UNKNOWN`). | PASS |
| 24 | At least one at-rest store is present (CMP-04). | PASS |
| 25 | At least one confidence low/medium case is present (F4 medium, F5 low). | PASS |

## 3. Annotation Model Coverage

| # | Check | Status |
|---|---|---|
| 26 | data class — exercised (C2, C4, C4P, DC-UNKNOWN). | PASS |
| 27 | authentication — exercised (IA1, SA1). | PASS |
| 28 | authorization — exercised (AZ-UNKNOWN at F4). | PASS |
| 29 | transport protection — exercised (T1 on F1, TP-UNKNOWN on F4). | PASS |
| 30 | at-rest protection — exercised (E1 component-scope at CMP-04). | PASS |
| 31 | confidence — exercised (high/medium/low rows). | PASS |
| 32 | proof-vs-signal — exercised (`S1`, `E1`, `T1`, gateway label all recorded as signal). | PASS |
| 33 | boundary crossing — exercised (BC-01..BC-07). | PASS |
| 34 | control / security-stack markers — exercised (`SSM-STACK-DIAMOND`, `SSM-GATEWAY-OR-POLICY-CHECKPOINT`, transit and at-rest markers). | PASS |

## 4. Template Alignment

| # | Check | Status |
|---|---|---|
| 35 | Each of the 26 expected baselines names its mirroring Package 09 template in YAML front matter `mirrors_template`. | PASS |
| 36 | Required sections in each baseline match the named template's `required_sections` list. | PASS |
| 37 | All `<value-from-catalogs/...>` placeholders resolve to existing entries in `catalogs/catalog-registry.yaml#catalogs[]`. | PASS |
| 38 | All blueprint identifiers (`BP-AI-SAAS-INTEGRATION`, `BP-MODEL-ENDPOINT-CALL`, `BP-HITL-APPROVAL`, `BP-API-WRITEBACK`) and material-missing-fact IDs resolve to entries in `blueprints/blueprint-registry.yaml`. | PASS |
| 39 | Every expected baseline references prompt + skill + PRA + adapter where applicable. | PASS |
| 40 | Only the 7 approved run-profile placeholders are used inside expected-baseline bodies. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. | PASS |

## 5. Synthetic-Data Safety

| # | Check | Status |
|---|---|---|
| 41 | No real PII / PAN / SSN / PHI in any input or expected baseline. | PASS |
| 42 | No real secrets / credentials in any input or expected baseline. | PASS |
| 43 | No real production endpoints or vendor-specific commercial product names asserted as mandatory. | PASS |
| 44 | C5 / C5* / PCI / PAN / SSN / PHI tokens are explicitly out-of-scope and recorded so in `samples/sample-001-dfd-crop/inputs/intake-ticket.md` § 1, `samples/sample-001-dfd-crop/inputs/dfd-legend-excerpt.md` § 2, and `samples/sample-001-dfd-crop/README.md` § 13. | PASS |

## 6. No Forbidden Claims

| # | Check | Status |
|---|---|---|
| 45 | No runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform claim appears in inputs or baselines. | PASS |
| 46 | No `executed_by_operator` claim appears in inputs or baselines. F8 / CMP-08 are `formatted_only`. | PASS |
| 47 | No new BP-* identifiers introduced inside any sample artefact. | PASS |
| 48 | No new catalog values introduced inside any sample artefact. | PASS |
| 49 | No `qualitative_score` produced inside expected baselines except the qualitative `PASS_READY_FOR_REVIEW` verdict in `expected-17-accuracy-score.md` (which mirrors `templates/output/output-17-accuracy-score-template.md`'s required Verdict section and explicitly defers numeric scoring to Build Package 11). | PASS |
| 50 | Severity, finding-category, AI Action Level, and blueprint match selection are recorded as outcomes only — never computed inside the baseline body. | PASS |

## 7. No Run Outputs Created

| # | Check | Status |
|---|---|---|
| 51 | No `runs/RUN-*/` folder is created by Build Package 10. | PASS |
| 52 | No `00-run-log.md` is appended by Build Package 10. | PASS |

## 8. Sealed Upstream Registries

| # | Check | Status |
|---|---|---|
| 53 | `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/` are not modified by Build Package 10. | PASS |
| 54 | The old reference workspace `D:\E-Way 2\aisraf-sas-prototype-skill-chain-pack-v0.01` is not modified. | PASS |

## 9. Tool Compatibility

| # | Check | Status |
|---|---|---|
| 55 | `tools/Test-AisrafPackage.ps1` carries the Build Package 10 surgical patch (header text "Build Package 01-10"; samples/ removed from README-only rule; Check `08h-samples-content-limits` added; Check 11 validation allow-list extended). | PASS |
| 56 | `tools/Test-AisrafPackage.ps1` runs to 0 FAIL after Build Package 10. | PASS |

## 10. Acceptance Verdict

Build Package 10 is **ready for human review** when every row above reads PASS. Numeric scoring is deferred to Build Package 11; the per-baseline qualitative verdict is `PASS_READY_FOR_REVIEW`.

## Out-of-Scope For Build Package 10

- Live runs under `runs/`.
- New prompts, skills, PRAs, adapters, catalogs, blueprints, or templates.
- Diagrams package assets (Build Package 13).
- Practitioner / runbook prose (Build Package 14).
- Release artefacts / ZIP (Build Package 15).
- Final QA seal (Build Package 16).
- Sample-002 through sample-008 folders (registry only).
- Numeric accuracy threshold lock — deferred to Build Package 11.
