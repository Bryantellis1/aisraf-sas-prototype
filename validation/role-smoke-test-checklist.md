# Role Smoke Test Checklist (BP12C)

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. This checklist defines the gates the 7 wrappers must pass when an operator selects each wrapper with no input. It does not author the wrappers.

## Purpose

Confirm each wrapper, when selected with no input, surfaces its Operator-Experience Instruction Surface and refuses to write. Roles must be self-explanatory before any chain runs.

## Test Procedure (per wrapper)

1. Operator opens the Copilot Chat customizations panel (or Claude Code skill picker) and selects the wrapper.
2. Operator enters no message; or sends a stub like `who are you?`, `what do you do?`, or `help`.
3. Operator captures the wrapper's response.
4. Operator runs `pwsh -NoProfile -File tools/Test-AisrafBp12AReadiness.ps1` and confirms 0 FAIL after the smoke.

## Gates — Per-Wrapper Role Smoke (R1–R7)

For each wrapper, all 7 sub-gates a–g must pass.

### R1 — `aisraf-orchestration`

| Sub-gate | Falsifiable Check |
|---|---|
| a — Role explanation present | Response contains the wrapper's role paragraph (≤120 words) and the literal phrase `owns no skill` (orchestrator exception). |
| b — What/Why/How for each output | Response enumerates `runs/{{run_id}}/00-run-log.md` with `What:`, `Why:`, `How:` lines. |
| c — No fake proof | Response contains the BP06 no-fake-proof prohibition; no positive-execution-claim regex matches. |
| d — Preserve unknowns mentioned | Response references the unknown-handling policy (carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, etc.). |
| e — Stop conditions listed | Response carries ≥3 stop conditions byte-equal to lines from `.agents/aisraf-orchestrator.agent.md` §11. |
| f — Output paths shown | Response lists template-style `runs/{{run_id}}/00-run-log.md` (not hard-coded `RUN-001`). |
| g — No write performed | `Get-UnauthorizedRunOutputs` returns the same set before and after the smoke. |

### R2 — `aisraf-input-read`

Sub-gates a–g (same shape as R1) against:
- Output path: `runs/{{run_id}}/01-input-inventory.md`.
- Adapter: `.agents/aisraf-input-reader.agent.md`.
- Canonical skill: `skills/rs/SK-INPUT-PACKAGE-READ.md`.

### R3 — `aisraf-dfd-extraction`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/02-..-05-*.md` and `runs/{{run_id}}/dfd/01-..-09-*.md`.
- Adapter: `.agents/aisraf-dfd-extractor.agent.md`.
- Canonical skills: 5 RS DFD-related + 9 DFD chain skills.

### R4 — `aisraf-review-table-build`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md`.
- Adapter: `.agents/aisraf-review-table-builder.agent.md`.
- Canonical skills: `SK-BOUNDARY-CROSSING-DETECT`, `SK-SECURITY-STACK-ASSESS`, `SK-DATA-FLOW-TABLE-BUILD`.

### R5 — `aisraf-blueprint-questioning`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md`.
- Adapter: `.agents/aisraf-blueprint-questioner.agent.md`.
- Canonical skills: `SK-MISSING-FACT-IDENTIFY`, `SK-AI-ACTION-LEVEL-CLASSIFY`, `SK-REVIEW-BLUEPRINT-MATCH`, `SK-TARGETED-QUESTION-GENERATE`.
- Extra: response must NOT enumerate AAL bands or blueprint match states beyond a `<value-from-catalogs/...>` placeholder reference.

### R6 — `aisraf-finding-recommendation`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/13-findings.md`, `14-recommendations.md`.
- Adapter: `.agents/aisraf-finding-recommender.agent.md`.
- Canonical skills: `SK-FINDING-CLASSIFY`, `SK-RECOMMENDATION-WRITE`.

### R7 — `aisraf-handoff-qa-score`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md`.
- Adapter: `.agents/aisraf-handoff-qa-scorer.agent.md`.
- Canonical skills: `SK-HANDOFF-PACK-BUILD`, `SK-VALIDATION-NOTE-WRITE`, `SK-ACCURACY-SCORE`.
- Extra: response must NOT compute or imply a numeric score; scoring activates only on chain execution.

## Gates — Cross-Wrapper Invariants (X1–X3)

| # | Gate | Falsifiable Check |
|---|---|---|
| X1 | No wrapper writes during role smoke | `Get-UnauthorizedRunOutputs` (BP12A function) returns the same set before and after the full 7-wrapper smoke. |
| X2 | No wrapper claims execution during role smoke | `Test-PositiveExecutionClaim` (BP12A function) returns `$null` for every captured wrapper response. |
| X3 | No wrapper modifies governed surfaces | After the full 7-wrapper smoke, `git diff` shows no changes under `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/`, `.agents/`, `.github/`, or `runs/RUN-001/`. |

## Acceptance Verdict (BP12C-Implementation step)

**PASS** when: R1–R7 all green (each with sub-gates a–g) AND X1–X3 green AND `Test-AisrafBp12AReadiness.ps1` returns 0 FAIL after the full smoke.

## Stop Conditions

- Any wrapper writing during role smoke.
- Any wrapper claiming execution during role smoke.
- Any wrapper hard-coding `RUN-001` in an output path string (must use `{{run_id}}`).
- Any wrapper enumerating catalog values, AAL bands, blueprint match states, or accuracy bands inline.
- Either core validator regressing.

## L2A Role-Smoke Runbook (WP-12C-L2A-UX)

This runbook is the operator-facing form of the BP12C role smoke gates above.
It lists the seven preview-only prompts and the expected evidence each role
must produce when invoked from the **installed plugin** in the isolated smoke
workspace `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`.

Do not run this runbook from the governed repo workspace
(`D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`); local projection folders
(`.agents/`, `.copilot-skills/`, `.github/agents/`, `.github/skills/`,
`.github/hooks/`) can contaminate provider discovery and invalidate the
evidence row.

### Operator Preconditions

1. Smoke workspace `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE` is open in VS Code.
2. The AISRAF plugin is installed (L1A accepted).
3. Terminal pane is large; scrollback increased.
4. One role prompt is run at a time.
5. Screenshots or copy / paste output captured per row.

### Common Prompt Body

Replace `<AISRAF role name>` per row:

```text
ROLE SMOKE TEST - WP-12C-L2A. Selected role: <AISRAF role name>. Preview only - write nothing. Do not modify RUN-001. Do not modify samples. Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, Microsoft Agent Framework, Azure AI Foundry, Google ADK, Anthropic Claude, database, Terraform, release, or post-back execution. Read only the role adapter, the operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

### Six Expected-Evidence Items (Per Role)

Mark a row PASS only when every item is satisfied.

1. Role responds.
2. Role identifies its responsibility.
3. Role references the expected governed output shape.
4. Role stays preview-only.
5. No files written.
6. No external execution claim.

### Per-Role Expected Evidence

| Row | Role Selection | PASS Names PRA | PASS References Output Shape (theoretical) | Notes |
|---|---|---|---|---|
| L2A-R1 | `@aisraf-orchestrator` | `PRA-01-SAS-REVIEW-ORCHESTRATOR` | `runs/{{run_id}}/00-run-log.md` | Orchestrator owns no skill; must say so. |
| L2A-R2 | `@aisraf-input-reader` | `PRA-02-INPUT-READER` | `runs/{{run_id}}/01-input-inventory.md` | References `skills/rs/SK-INPUT-PACKAGE-READ.md`. |
| L2A-R3 | `@aisraf-dfd-extractor` | `PRA-03-DFD-EXTRACTOR` and `PRA-04-LEGEND-NORMALIZER` | `runs/{{run_id}}/02-..-05-*.md` and `runs/{{run_id}}/dfd/01-..-09-*.md` | Must acknowledge PRA-04 has no separate adapter. |
| L2A-R4 | `@aisraf-review-table-builder` | `PRA-05-REVIEW-TABLE-BUILDER` | `runs/{{run_id}}/06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` | Must not claim controls without evidence. |
| L2A-R5 | `@aisraf-blueprint-questioner` | `PRA-06-BLUEPRINT-QUESTIONER` | `runs/{{run_id}}/09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md` | Must not enumerate AAL bands or blueprint match states inline. |
| L2A-R6 | `@aisraf-finding-recommender` | `PRA-07-FINDING-RECOMMENDER` | `runs/{{run_id}}/13-findings.md`, `14-recommendations.md` | UX caveat: output may interleave; accept if role identity and shape are still attributable; capture screenshot. |
| L2A-R7 | `@aisraf-handoff-qa-scorer` | `PRA-08-HANDOFF-QA-SCORER` | `runs/{{run_id}}/15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` | Must not compute or imply a numeric score. |

### Falsifiers

- Any role writes a file during the runbook.
- Any role claims runtime / cloud / Jira / Confluence / Lucidchart / MCP / ADK / MAF / Foundry / Claude / database / Terraform / external post-back execution.
- Any role hard-codes `RUN-001` in its declared output path (must use `{{run_id}}`).
- Any row captured from the governed repo workspace instead of the smoke workspace.
- Any row missing capture method, single-role attribution, or workspace path.

### L2A Acceptance Note

L2A closed with all seven rows accepted, and L2A-R6 carrying a UX caveat
because output was interleaved, not functionally wrong. The UX caveat is
addressed in the operator usability patch documented in
`validation/package-12c-plugin-install-and-publication-checklist.md`
§20.3 (terminal posture) and §20.4 (runbook).

### L2A Final Status

`WP-12C-L2A_PREVIEW_ROLE_SMOKE_PASS_READY_FOR_UX_FIX` (closed).

## Security Architect Role Guide (WP-12C-L2B-UXA)

Use this guide when a security architect asks which AISRAF role to select in
the installed plugin. Role smoke remains preview-only. L2B controlled-output
execution writes only after explicit founder approval and only under
`runs/RUN-SMOKE-PLUGIN-L2B-001/`.

| Role | Business Value | When To Use | Reads | May Write During L2B | Expected Output | Must Not Claim | Evidence To Capture |
|---|---|---|---|---|---|---|---|
| `@aisraf-orchestrator` | Coordinates the local review chain and run log. | Start, sequence, or close a run. | Run profile, accepted prior outputs, role stop rules. | `00-run-log.md` | Run identity, step ledger, stop conditions, final status. | Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, release, or post-back execution. | Role transcript, run-log guard result, focused validator result. |
| `@aisraf-input-reader` | Inventories the design-review package. | After the local input package is staged. | DFD source/image, legend, ticket text, notes, transcript, run profile. | `01-input-inventory.md` | Input inventory, unknowns, stop conditions. | Chat attachment movement, requester-form creation, hidden input invention. | Inventory transcript/output, files read, validator result. |
| `@aisraf-dfd-extractor` | Extracts visible DFD facts and normalizes DFD evidence. | When DFD image/source and supporting notes are available. | Input inventory, DFD image/source, legend, notes, transcript. | `02-visible-dfd-objects.md`, `03-legend-normalization.md`, `04-components.md`, `05-flows.md`, and `dfd/01` through `dfd/09`. | Visible objects, legend normalization, components, flows, DFD subchain artifacts. | Diagram generation, hidden inference, runtime proof, or invented facts. | Per-output guard and validator results, unknown handling evidence. |
| `@aisraf-review-table-builder` | Builds boundary, security-stack, and internal review evidence. | After DFD components and flows exist. | Components, flows, legend normalization, DFD control signals. | `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` | Boundary rows, security-stack signal rows, internal review table. | Approved-control claims without evidence or proof beyond the source package. | Review table transcript/output, guard and validator results. |
| `@aisraf-blueprint-questioner` | Identifies missing facts and targeted questions. | Before or during design review when gaps remain. | Input inventory, DFD outputs, review table, blueprints and catalogs by reference. | `09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md` | Missing facts, AI Action Level record, blueprint match record, targeted questions. | Final blueprint/AAL claims without evidence, catalog enumeration, broad checklist invention. | Question list, source missing-fact links, validator result. |
| `@aisraf-finding-recommender` | Drafts evidence-bound findings and recommendations. | After review table, missing facts, and blueprint outputs exist. | Boundaries, security-stack, review table, missing facts, questions, blueprint outputs. | `13-findings.md`, `14-recommendations.md` | Finding rows and recommendation rows with parent traceability. | Owner invention, implementation proof, recommendation without parent finding. | Finding/recommendation IDs, parent links, validator result. |
| `@aisraf-handoff-qa-scorer` | Builds closeout package, validation notes, and governed score output. | At closeout after prior outputs exist. | Outputs `08` through `16`, expected baselines when scoring is enabled, run profile. | `15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` | Handoff pack, separate validation notes, scoring eligibility and result. | Numeric score without scoring gates, expected-baseline edits, external posting. | Handoff pack, validation notes, score eligibility, validator result. |

## DFD Review Annotation Requirements

DFD-derived outputs should preserve these annotations when visible in the input
package:

- Data classification.
- Source.
- Destination.
- Trust or boundary crossing.
- Authentication signal.
- Authorization signal.
- Encryption in transit.
- Encryption at rest for stores.
- Logging, monitoring, or control evidence.
- Unknown values carried forward rather than invented.

If an annotation is not visible or supported by the package, record `unknown`
and carry it forward into downstream outputs.

## UXA Evidence Capture Reminder

Acceptable evidence includes copied terminal output, screenshots, saved
transcript text, validator transcript, and Git hygiene transcript. Use
`"terminal.integrated.scrollback": 50000`, run one role at a time, and stop if
output becomes unattributable. Copilot CLI is secondary/noisy and is not the
blocking Local provider proof surface.
