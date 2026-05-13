# AISRAF Prompts, Skills, Agents, and Testing Guide

Package: AISRAF SAS Prototype v0.1.2
Audience: stakeholders, evaluators, security architects, application architects, maintainers, contributors, and founders who need to understand what AISRAF is, how it is assembled, and how to test it locally.

> **Posture.** AISRAF v0.1.2 is a **public source-available evaluation-only proof-of-concept**. It is **not open source**, **not production software**, and **not marketplace-published**. AISRAF performs **no current external adapter execution** (Connected Review Flow — Flow 4 — is planned for v0.2.0). **Closed-loop autonomy is out of scope.** This guide documents Local Orchestrated Review (Flow 1) and Run Observability (Flow 2) as the current public flows; the legacy `Mode N` numbering used below is preserved as **internal architecture/evidence vocabulary** only. See [PRODUCT-FLOW-ROADMAP.md](PRODUCT-FLOW-ROADMAP.md) for the public seven-flow operating model.

## Section 1 — Plain-English Overview

- **AISRAF is a local-first security architecture review workbench.** A practitioner opens the package in VS Code with GitHub Copilot, points the orchestrator at a personal run folder, and receives 26 structured Markdown outputs (17 RS + 9 DFD) under that run folder.
- **Public source-available evaluation-only.** The repository is published so that stakeholders can read, evaluate, and reproduce the local workbench. It does not grant production use, redistribution rights, marketplace publication rights, or hosted-service rights.
- **Not open source.** No OSI-approved license is asserted. Evaluation only.
- **Not production software.** No SLOs, no operational support, no hardening claim.
- **Not marketplace-published.** No GitHub Marketplace, Visual Studio Marketplace, or Copilot extension marketplace listing exists.
- **No current external adapter execution.** Jira, Confluence, Lucidchart, Rovo / MCP, cloud, database, Terraform, event bus, telemetry, and post-back execution are part of the planned **Connected Review Flow (Flow 4, v0.2.0)** and are **not implemented in v0.1.2**. (Internal vocabulary: Mode 4 / AM4.)
- **No current online threat-intelligence execution.** Threat Intelligence Enrichment is planned as **Flow 5 (v0.2.1)** via the `SKL-THREAT-INTEL-CURRENT-CONTEXT` skill and is **not implemented in v0.1.2**.
- **No current Mermaid generation feature.** Mermaid Diagram Generation is planned as **Flow 6** and is **not implemented in v0.1.2**.
- **Closed-loop autonomy is out of scope.** AISRAF does not act without human gates and does not attempt self-directed deployment, remediation, or closed-loop policy enforcement. (Internal vocabulary: AL5.)

In plain English: AISRAF reads governed prompt cards, skill contracts, and prototype-agent specifications, wraps them in local provider/operator agent adapters, and asks the operator to drive a controlled DFD-and-review pipeline against a personal run folder.

## Section 2 — How AISRAF Is Put Together

AISRAF is a chain of governed surfaces. Each surface has a single owner and feeds the next surface. No surface executes external adapters in v0.1.2.

| # | Surface | Folder | What lives here | Owning Build Package |
|---|---|---|---|---|
| 1 | Prompt cards | `prompts/` (`prompts/rs/`, `prompts/dfd/`) | 23 operator-facing instructions (14 RS + 9 DFD) and `prompts/prompt-registry.yaml`. | 04 |
| 2 | Skill contracts | `skills/` (`skills/rs/`, `skills/dfd/`) | 26 skill contracts (17 RS + 9 DFD) and `skills/skill-registry.yaml`. | 05 |
| 3 | Prototype Review Agent specs | `prototype-agents/` | 8 PRA specifications (`PRA-01` through `PRA-08`) and `prototype-agent-registry.yaml`. | 06 |
| 4 | Local Copilot adapter wrappers | `.agents/` | 7 thin local `.agent.md` wrappers that point a VS Code + GitHub Copilot session at the canonical sources. | 06 / 12C |
| 5 | Provider agent surface | `.github/agents/` | 7 governed provider-projection `.agent.md` files (identical to `.agents/` peers). | 12C |
| 6 | Provider skill packages | `.github/skills/` | Governed provider-skill packages mirroring `skills/`. | 12C |
| 7 | Operator skill wrappers | `.copilot-skills/` | Operator-facing Copilot-skill cards mirroring `skills/`. | 12C-H |
| 8 | Catalogs | `catalogs/` | 24 controlled-vocabulary catalogs across 7 families plus `catalog-registry.yaml`. | 07 |
| 9 | Blueprints | `blueprints/` | 9 controlled YAML blueprints (`platform-independent/` × 8, `cloud-patterns/` × 1) plus `blueprint-registry.yaml`. | 08 |
| 10 | Templates | `templates/` | 31 reusable output-shape templates across `output/`, `jira/`, `confluence/`, `run/` plus `template-registry.yaml`. | 09 |
| 11 | Samples | `samples/` | 1 active gold-standard sample (`sample-001-dfd-crop`), 6 synthetic inputs, 26 expected baselines, plus `sample-registry.yaml`. | 10 |
| 12 | Run profiles + run fixture | `config/run-profile.schema.yaml` + `runs/<run_id>/run-profile.yaml` | Run-profile schema and the governed fixture `runs/RUN-001/`. Operators create their own personal `runs/<run_id>/` folders. | 02 / 11 |
| 13 | Validators | `tools/` | `Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1`, `Test-AisrafAm3Runtime.ps1`, `Invoke-AisrafAm3LocalRun.ps1`, `New-AisrafRun.ps1`, and `tools/hooks/`. | 03 / 12C |
| 14 | Evidence and QA reports | `validation/` | The validation taxonomy (`no-drift-rules.md`, checklists, release readiness, BP-12C reports). | 12 |
| 15 | Diagrams | `diagrams/release-v0.1.2/` | First public visual pack (PNG + SVG + source) registered in `diagrams/diagram-registry.yaml`. | 13 |

**The flow.** A prompt card declares operator instructions and required outputs. A skill contract wraps that prompt card into a reusable work unit with input/output expectations, evidence rules, validation rules, and failure modes. A PRA specification describes the prototype review agent that would orchestrate the skill in a full implementation. A local `.agent.md` adapter projects the PRA into a Copilot-callable wrapper. Catalogs give the prompt and skill a controlled vocabulary. Blueprints declare reusable architecture patterns. Templates declare reusable output shapes. Samples provide gold-standard input/expected pairs. Run profiles parameterize a single run. Validators prove the surface and the run profile are healthy. Diagrams visualize the chain.

## Section 3 — Prompt Inventory

`prompts/` contains 23 prompt cards plus `prompts/prompt-registry.yaml`. Prompt cards are operator-facing instructions, not runtime tools.

### 3.1 RS prompt family (14 cards)

The RS family produces the 17-row review summary chain. Cards are numbered to match the corresponding output number (`01-input-inventory.md` through `17-accuracy-score.md`). The full-chain wrapper `prompts/rs/00-run-full-chain.prompt.md` is `status: planned` and writes no output of its own. RS output `12-targeted-questions.md` is produced by `prompts/rs/07-missing-fact-question-generate.prompt.md` together with `09-missing-facts.md`.

### 3.2 DFD prompt family (9 cards)

The DFD family produces the 9-row DFD chain outputs under `<run_id>/dfd/dfd-01-intake-quality-check.md` through `dfd-09-extraction-summary.md`. The cards drive the local Mode 1 DFD extraction journey.

### 3.3 Prompt registry purpose

`prompts/prompt-registry.yaml` declares the canonical prompt root, the prompt families, the required prompt sections (Identity, Purpose, Run Profile Inputs, Required Read Paths, Required Output, Instructions, Stop Conditions, Unknown Handling, Evidence / Run-Log Guidance, Direct Prompt Test, Not In Scope), and the forbidden-claims list (no skill execution, no PRA execution, no adapter execution, no external post-back, no scoring proof outside SK-ACCURACY-SCORE, no release/diagram export).

### 3.4 What prompt cards do NOT do

- Prompt cards **do not execute Jira, Confluence, Lucidchart, Rovo, MCP, cloud, database, Terraform, event bus, telemetry, or post-back behavior**.
- Prompt cards **do not write outside the resolved `{{output_root}}`** (the run folder).
- Prompt cards **do not claim full-chain orchestration** or scoring proof.
- Prompt cards **do not hardcode** `run_id`, `sample_id`, paths, source/destination URLs, `output_destination_mode`, or `postback_execution_status`. They use only run-profile variables.

## Section 4 — Skill Inventory

`skills/` contains 26 skill contracts plus `skills/skill-registry.yaml`. Skill contracts wrap prompt-card behaviour into reusable work units. They are not executable runtime tools.

### 4.1 RS skill contracts (17)

One skill contract per RS output. `SK-ACCURACY-SCORE.md` is the only skill that may produce a numeric accuracy score, and only when the mapped prompt's scoring conditions are met.

### 4.2 DFD skill contracts (9)

One skill contract per DFD output. DFD skill contracts may write to `{{output_root}}/dfd/` only.

### 4.3 Skill registry purpose

`skills/skill-registry.yaml` declares the canonical skill root, the skill families, the required skill sections (Identity, Purpose, Required Inputs, Optional Inputs, Required Outputs, Procedure, Stop Conditions, Unknown Handling, Confidence Handling, Critical Misses, Human Review Gate, Validation / Scoring Relationship, Direct Skill Test, Not In Scope), and the forbidden-claims list (no PRA execution, no adapter execution, no external post-back, no scoring proof outside `SK-ACCURACY-SCORE`, no release / diagram export).

### 4.4 What skill contracts declare

- **Inputs.** Required inputs and optional inputs, expressed against run-profile variables.
- **Outputs.** Single named output Markdown file under `{{output_root}}` or `{{output_root}}/dfd/`.
- **Evidence requirements.** What goes into the run log; what must be cited; what must be redacted.
- **Validation rules.** Stop conditions, critical misses, human review gate, and confidence handling.
- **Failure modes.** Unknown handling and `UNKNOWN — <reason>` patterns.
- **Allowed surfaces.** Skill writes must resolve under `{{output_root}}` only.

## Section 5 — Agent Inventory

AISRAF v0.1.2 ships **seven** local Copilot adapter wrappers under `.agents/` and an identical governed provider projection under `.github/agents/`. The agents wrap the eight PRA specifications under `prototype-agents/` (`PRA-04 Legend Normalizer` is embedded inside `PRA-03 DFD Extractor` at runtime and is therefore not a standalone provider agent).

| # | Agent | Role |
|---|---|---|
| 1 | `@aisraf-orchestrator` | Recommended entry point. Coordinates the local folder-first review against a personal run profile, drives AM3-01 through AM3-06 handoffs, and owns run-state and event log. |
| 2 | `@aisraf-input-reader` | PRA-02 wrapper. Reads `runs/<run_id>/inputs/` and produces `01-input-inventory.md`. |
| 3 | `@aisraf-dfd-extractor` | PRA-03 wrapper. Drives the 9-row DFD chain and the embedded PRA-04 legend normalisation. |
| 4 | `@aisraf-review-table-builder` | PRA-05 wrapper. Assembles the 17-row RS review table. |
| 5 | `@aisraf-blueprint-questioner` | PRA-06 wrapper. Asks blueprint-driven gap and pattern questions. |
| 6 | `@aisraf-finding-recommender` | PRA-07 wrapper. Generates findings and recommendations. |
| 7 | `@aisraf-handoff-qa-scorer` | PRA-08 wrapper. Scores handoff quality and accuracy. |

**Entry-point rules.**

- **Start with `@aisraf-orchestrator`.** It is the recommended entry point for a complete local folder-first review.
- **Specialist agents are direct expert entry points.** A reviewer who only wants a DFD extraction or only wants the review table can call the specialist agent directly.
- **Agents are local/provider wrappers over governed source material.** They do not invent new prompts, skills, PRAs, catalogs, blueprints, templates, or run-profile fields. They cite the canonical source surface.
- **Agents do not make AM4 external adapter calls in v0.1.2.** No Jira ticket, no Confluence page, no Lucidchart diagram, no Rovo / MCP request, no cloud call, no database write, no Terraform apply, no event bus message, no telemetry post-back.

## Section 6 — Prompt → Skill → Agent → Output Traceability

The table below traces every visible v0.1.2 review stage from prompt card → skill contract → agent / PRA → output file → evidence rule → validator or checklist. Use it to confirm a given output is governed end-to-end.

| # | Review stage | Prompt | Skill | Agent / PRA | Output file (under `runs/<run_id>/`) | Evidence rule | Validator / checklist |
|---|---|---|---|---|---|---|---|
| 1 | RS — input inventory | `prompts/rs/01-input-inventory.prompt.md` | `skills/rs/SK-INPUT-INVENTORY.md` | `@aisraf-input-reader` / PRA-02 | `01-input-inventory.md` | List each `inputs/` artifact with type and source. | `validation/expected-output-lint-checklist.md` |
| 2 | RS — review summary table | `prompts/rs/02-review-summary-table.prompt.md` | `skills/rs/SK-REVIEW-SUMMARY-TABLE.md` | `@aisraf-review-table-builder` / PRA-05 | `02-review-summary-table.md` | Cite catalog rows; declare `UNKNOWN — <reason>` for missing facts. | `validation/expected-output-lint-checklist.md` |
| 3 | RS — review row scan | `prompts/rs/03-review-row-scan.prompt.md` | `skills/rs/SK-REVIEW-ROW-SCAN.md` | `@aisraf-review-table-builder` / PRA-05 | `03-review-row-scan.md` | Mirror each row of `02-review-summary-table.md`. | `validation/expected-output-lint-checklist.md` |
| 4 | RS — blueprint match | `prompts/rs/04-blueprint-match.prompt.md` | `skills/rs/SK-BLUEPRINT-MATCH.md` | `@aisraf-blueprint-questioner` / PRA-06 | `04-blueprint-match.md` | Cite a blueprint from `blueprints/blueprint-registry.yaml`. | `validation/blueprint-catalog-consumption-checklist.md` |
| 5 | RS — blueprint gap | `prompts/rs/05-blueprint-gap.prompt.md` | `skills/rs/SK-BLUEPRINT-GAP.md` | `@aisraf-blueprint-questioner` / PRA-06 | `05-blueprint-gap.md` | Cite missing catalog rows; mark `UNKNOWN`. | `validation/blueprint-registry-checklist.md` |
| 6 | RS — findings | `prompts/rs/06-findings.prompt.md` | `skills/rs/SK-FINDINGS.md` | `@aisraf-finding-recommender` / PRA-07 | `06-findings.md` | Cite skill, catalog row, and blueprint. | `validation/expected-output-lint-checklist.md` |
| 7 | RS — recommendations | `prompts/rs/07-missing-fact-question-generate.prompt.md` (joined) | `skills/rs/SK-RECOMMENDATIONS.md` | `@aisraf-finding-recommender` / PRA-07 | `07-recommendations.md` | Map each finding to a recommendation. | `validation/expected-output-lint-checklist.md` |
| 8 | RS — risk register | `prompts/rs/08-risk-register.prompt.md` | `skills/rs/SK-RISK-REGISTER.md` | `@aisraf-finding-recommender` / PRA-07 | `08-risk-register.md` | Cite each finding's risk. | `validation/expected-output-lint-checklist.md` |
| 9 | RS — missing facts | `prompts/rs/07-missing-fact-question-generate.prompt.md` | `skills/rs/SK-MISSING-FACTS.md` | `@aisraf-blueprint-questioner` / PRA-06 | `09-missing-facts.md` | List each missing fact with citation. | `validation/expected-output-lint-checklist.md` |
| 10 | RS — clarifying questions | `prompts/rs/10-clarifying-questions.prompt.md` | `skills/rs/SK-CLARIFYING-QUESTIONS.md` | `@aisraf-blueprint-questioner` / PRA-06 | `10-clarifying-questions.md` | One question per missing fact. | `validation/expected-output-lint-checklist.md` |
| 11 | RS — proposed answers | `prompts/rs/11-proposed-answers.prompt.md` | `skills/rs/SK-PROPOSED-ANSWERS.md` | `@aisraf-blueprint-questioner` / PRA-06 | `11-proposed-answers.md` | Each answer cites a catalog row or `UNKNOWN`. | `validation/expected-output-lint-checklist.md` |
| 12 | RS — targeted questions | `prompts/rs/07-missing-fact-question-generate.prompt.md` | `skills/rs/SK-TARGETED-QUESTIONS.md` | `@aisraf-blueprint-questioner` / PRA-06 | `12-targeted-questions.md` | Joined with `09-missing-facts.md`. | `validation/expected-output-lint-checklist.md` |
| 13 | RS — Jira draft (Markdown) | `prompts/rs/13-jira-draft.prompt.md` | `skills/rs/SK-JIRA-DRAFT.md` | `@aisraf-finding-recommender` / PRA-07 | `13-jira-draft.md` | Local Markdown only; no post-back. | `validation/expected-output-lint-checklist.md` |
| 14 | RS — Confluence draft (Markdown) | `prompts/rs/14-confluence-draft.prompt.md` | `skills/rs/SK-CONFLUENCE-DRAFT.md` | `@aisraf-finding-recommender` / PRA-07 | `14-confluence-draft.md` | Local Markdown only; no publication. | `validation/expected-output-lint-checklist.md` |
| 15 | RS — handoff QA | `prompts/rs/15-handoff-qa.prompt.md` | `skills/rs/SK-HANDOFF-QA.md` | `@aisraf-handoff-qa-scorer` / PRA-08 | `15-handoff-qa.md` | Cite each handoff. | `validation/expected-output-lint-checklist.md` |
| 16 | RS — accuracy score | `prompts/rs/16-accuracy-score.prompt.md` | `skills/rs/SK-ACCURACY-SCORE.md` | `@aisraf-handoff-qa-scorer` / PRA-08 | `16-accuracy-score.md` | Numeric score only when the prompt's scoring conditions are met. | `validation/scoring-rubric-checklist.md` |
| 17 | RS — overall accuracy | `prompts/rs/17-accuracy-score.prompt.md` | `skills/rs/SK-ACCURACY-SCORE.md` (overall row) | `@aisraf-handoff-qa-scorer` / PRA-08 | `17-accuracy-score.md` | Aggregate; same constraints. | `validation/scoring-rubric-checklist.md` |
| 18 | DFD — intake quality check | `prompts/dfd/dfd-01-intake-quality-check.prompt.md` | `skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-01-intake-quality-check.md` | Inventory the `inputs/dfd-crop.mmd` file. | `validation/expected-output-lint-checklist.md` |
| 19 | DFD — boundary extraction | `prompts/dfd/dfd-02-boundary-extraction.prompt.md` | `skills/dfd/SK-DFD-02-BOUNDARY-EXTRACTION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-02-boundary-extraction.md` | Cite each `AZ#` boundary. | `validation/expected-output-lint-checklist.md` |
| 20 | DFD — component extraction | `prompts/dfd/dfd-03-component-extraction.prompt.md` | `skills/dfd/SK-DFD-03-COMPONENT-EXTRACTION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-03-component-extraction.md` | Cite each `CMP-NN`. | `validation/expected-output-lint-checklist.md` |
| 21 | DFD — flow extraction | `prompts/dfd/dfd-04-flow-extraction.prompt.md` | `skills/dfd/SK-DFD-04-FLOW-EXTRACTION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-04-flow-extraction.md` | Each flow uses the 4-token grammar. | `validation/expected-output-lint-checklist.md` |
| 22 | DFD — data-store extraction | `prompts/dfd/dfd-05-data-store-extraction.prompt.md` | `skills/dfd/SK-DFD-05-DATA-STORE-EXTRACTION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-05-data-store-extraction.md` | `<class> • R# • <Enc|Tok|Mask|Clr|Unknown>`. | `validation/expected-output-lint-checklist.md` |
| 23 | DFD — boundary-crossing extraction | `prompts/dfd/dfd-06-boundary-crossing-extraction.prompt.md` | `skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-EXTRACTION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-06-boundary-crossing-extraction.md` | Cite each `BND-NN`. | `validation/expected-output-lint-checklist.md` |
| 24 | DFD — trust-anchor extraction | `prompts/dfd/dfd-07-trust-anchor-extraction.prompt.md` | `skills/dfd/SK-DFD-07-TRUST-ANCHOR-EXTRACTION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-07-trust-anchor-extraction.md` | Cite each trust anchor. | `validation/expected-output-lint-checklist.md` |
| 25 | DFD — DFD reconciliation | `prompts/dfd/dfd-08-reconciliation.prompt.md` | `skills/dfd/SK-DFD-08-RECONCILIATION.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-08-reconciliation.md` | Reconcile boundary, component, flow, data-store, BND rows. | `validation/expected-output-lint-checklist.md` |
| 26 | DFD — extraction summary | `prompts/dfd/dfd-09-extraction-summary.prompt.md` | `skills/dfd/SK-DFD-09-EXTRACTION-SUMMARY.md` | `@aisraf-dfd-extractor` / PRA-03 | `dfd/dfd-09-extraction-summary.md` | Summarise the chain. | `validation/expected-output-lint-checklist.md` |

> **Note.** This is a stakeholder-facing map of the v0.1.2 chain. Authoritative prompt → skill → PRA mappings live in `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`, and `validation/prompt-skill-agent-mapping-checklist.md`. If this table and the registries disagree, the registries are authoritative.

## Section 7 — Local Test Journey

This is the recommended journey for a reviewer who wants to run AISRAF end-to-end against a personal review folder.

1. **Clone or download** the public GitHub repository: `https://github.com/Bryantellis1/aisraf-sas-prototype`.

2. **Open the repository folder in VS Code** with GitHub Copilot enabled.

3. **Start with `@aisraf-orchestrator`** from the Copilot chat surface. The orchestrator is the recommended entry point.

4. **Create a personal run folder** (use a fresh `RUN-MY-REVIEW-001`, not `RUN-001`):

   ```powershell
   pwsh -NoProfile -File ./tools/New-AisrafRun.ps1 -RunId RUN-MY-REVIEW-001 -SampleId sample-001-dfd-crop -CopySampleInputs
   ```

5. **Stage DFD and design-package inputs** under `runs/RUN-MY-REVIEW-001/inputs/`. For a smoke run, the `-CopySampleInputs` flag has already byte-copied `sample-001-dfd-crop` inputs. For a real review, replace those copies with your design package's DFD, component list, data classification, and supporting documents. Redact secrets and identifiers before staging.

6. **Edit `runs/RUN-MY-REVIEW-001/run-profile.yaml`**. Set `run_id`, `sample_id`, `mode`, `output_destination_mode`, `postback_execution_status`, and the human-readable description fields. Do **not** invent fields outside `config/run-profile.schema.yaml`.

7. **Confirm sensitive-data redaction** only after a human review of `inputs/`. Set `sensitive_data_confirmed_redacted: true` in the run profile only when the inputs are clean.

8. **Validate the run profile**:

   ```powershell
   pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-MY-REVIEW-001/run-profile.yaml -ExecutionReady
   ```

   The validator must report `12 PASS, 0 FAIL (level=ExecutionReady)`.

9. **Prompt the orchestrator** to run the local folder-first review:

   ```text
   @aisraf-orchestrator Run a local folder-first AISRAF review using runs/RUN-MY-REVIEW-001/run-profile.yaml. Do not use external adapters. Write outputs only under runs/RUN-MY-REVIEW-001/.
   ```

10. **Review the outputs** under `runs/RUN-MY-REVIEW-001/`: `00-run-log.md`, `01-input-inventory.md` through `17-accuracy-score.md`, and `dfd/dfd-01-intake-quality-check.md` through `dfd/dfd-09-extraction-summary.md`. Each output is local Markdown; nothing is posted back to Jira, Confluence, Lucidchart, Rovo, MCP, cloud, database, Terraform, event bus, or telemetry.

> Use a separate `runs/<run_id>/` folder for each separate DFD or review. **Do not use `runs/RUN-001/` for personal reviews; it is the governed fixture.**

## Section 8 — Expected Outputs

A completed local review produces the following files under the run folder.

### 8.1 Run log

- `00-run-log.md` — append-only log of every action taken during the run.

### 8.2 RS chain outputs (17)

- `01-input-inventory.md`
- `02-review-summary-table.md`
- `03-review-row-scan.md`
- `04-blueprint-match.md`
- `05-blueprint-gap.md`
- `06-findings.md`
- `07-recommendations.md`
- `08-risk-register.md`
- `09-missing-facts.md`
- `10-clarifying-questions.md`
- `11-proposed-answers.md`
- `12-targeted-questions.md`
- `13-jira-draft.md` *(local Markdown draft; no post-back to Jira)*
- `14-confluence-draft.md` *(local Markdown draft; no publication to Confluence)*
- `15-handoff-qa.md`
- `16-accuracy-score.md`
- `17-accuracy-score.md`

### 8.3 DFD chain outputs (9, under `dfd/`)

- `dfd/dfd-01-intake-quality-check.md`
- `dfd/dfd-02-boundary-extraction.md`
- `dfd/dfd-03-component-extraction.md`
- `dfd/dfd-04-flow-extraction.md`
- `dfd/dfd-05-data-store-extraction.md`
- `dfd/dfd-06-boundary-crossing-extraction.md`
- `dfd/dfd-07-trust-anchor-extraction.md`
- `dfd/dfd-08-reconciliation.md`
- `dfd/dfd-09-extraction-summary.md`

### 8.4 Local-only draft outputs

`13-jira-draft.md` and `14-confluence-draft.md` are **Markdown drafts written locally**. They are not Jira tickets, not Confluence pages, and not Rovo / MCP requests. AISRAF v0.1.2 makes **no external post-back**. A future AM4 adapter could project these drafts onto Jira and Confluence after explicit human approval, but that is future work.

### 8.5 What is NOT produced

- No `.docx`, `.pdf`, `.pptx`, or `.zip` outputs.
- No Lucidchart export. No Mermaid render outside the operator's editor.
- No cloud-deployment artefact, no Terraform plan, no database job, no event-bus message, no telemetry post-back.
- No marketplace plugin manifest activation.

## Section 9 — Validation Ladder

AISRAF v0.1.2 ships five governed validators. Run them before any release decision.

### 9.1 `Test-AisrafPackage.ps1` — package contract

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
```

Expected: **83 PASS, 3 WARN, 0 FAIL** at HEAD `75265ee`. The three WARN rows are the accepted smoke-run folders (`runs/RUN-SMOKE-AM3-001/`, `runs/RUN-SMOKE-LOCAL-001/`, `runs/RUN-SMOKE-PLUGIN-L2B-001/`) that must be removed before a stage/commit gate; they do not block evaluation. *(After this Stakeholder Asset Pack gate adds `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md` and `validation/package-12c-rel0-github-prerelease-stakeholder-asset-pack-report.md` to the allow-lists, the PASS count remains 83.)*

### 9.2 `Test-AisrafBp12AReadiness.ps1` — BP12A readiness

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
```

Expected: **77 PASS, 0 FAIL**.

### 9.3 `Test-AisrafRunProfile.ps1` — run-profile contract

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

Expected: **12 PASS, 0 FAIL (level=ExecutionReady)**.

### 9.4 `Test-AisrafAm3Runtime.ps1 -ContractsOnly` — AM3 contracts

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly
```

Expected: **4 PASS, 0 FAIL**.

### 9.5 `Test-AisrafAm3Runtime.ps1` — AM3 runtime evidence

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml
```

Expected: **23 PASS, 0 FAIL**. This proves the AM3 local orchestrated runtime evidence path (handoff request/response, gate request/decision, terminal events) is well-formed. It does **not** prove production-grade execution or AM4 adapter behavior.

### 9.6 Posture summary

| Validator | Expected | What it proves | What it does NOT prove |
|---|---|---|---|
| Package | 83 PASS, 3 WARN, 0 FAIL | Package surfaces are governed and complete. | Production readiness; AM4 execution; marketplace publication. |
| BP12A readiness | 77 PASS, 0 FAIL | The BP12A automated test harness gate is met. | Numeric output scoring. |
| Run profile | 12 PASS, 0 FAIL | A run profile is schema-conformant and execution-ready. | That the chain has been run against it. |
| AM3 ContractsOnly | 4 PASS, 0 FAIL | AM3 runtime/handoff/state/event contracts exist and parse. | That runtime evidence exists. |
| AM3 runtime | 23 PASS, 0 FAIL | A local AM3 smoke run produced valid handoff, gate, and terminal events. | That AISRAF executes AM4 adapters. |

## Section 10 — Public Operating Flows And Their Internal `Mode N` Names

The public operating model is the seven flows (see [PRODUCT-FLOW-ROADMAP.md](PRODUCT-FLOW-ROADMAP.md)). The `Mode 0`/`Mode 1`/`Mode 2`/`Mode 3`/`Mode 4` and `AM` / `AL` vocabulary used elsewhere in this guide is **internal architecture/evidence vocabulary** and is preserved here so that contributors reading older artifacts can translate without ambiguity. Public users should use the flow vocabulary.

| Public flow | Plain-English meaning | v0.1.2 status | Internal vocabulary |
|---|---|---|---|
| **Flow 1 — Local Orchestrated Review** | What a practitioner uses day to day: VS Code + Copilot, a personal run folder, governed prompt/skill/agent material, local Markdown outputs. The flow includes an optional preview-first step (no writes). | Current everyday security architect and application architect flow. | Mode 0 + Mode 1 / AL2 |
| **Flow 2 — Run Observability** | Captured alongside Flow 1. Target evidence set per run: `00-run-log.md`, `runtime/run-state.yaml` (or equivalent), `runtime/events.ndjson` (or equivalent), handoff records, human gate records, validation result summary. v0.1.2 emits this evidence through a local runtime evidence harness; the target product experience is for the orchestrator to auto-emit during Flow 1. | Current release-visible evidence path. | Mode 2 / AM3 / AL3 |
| **Flow 3 — Release QA Flow** | The maintainer runs the five validators, inspects diagrams, reviews `validation/` reports, and decides whether to publish. | Current maintainer-only path. | Mode 3 |
| **Flow 4 — Connected Review Flow** | AISRAF would call Jira, Confluence, Lucidchart, Rovo / MCP, cloud, database, Terraform, event bus, telemetry, or post-back targets — under operator approval, with local Markdown fallback always retained. | **Planned (v0.2.0). Not part of v0.1.2.** | Mode 4 / AM4 / AL4 |
| **Flow 5 — Threat Intelligence Enrichment** | `SKL-THREAT-INTEL-CURRENT-CONTEXT` over NVD CVE API, CISA KEV, vendor advisories, official product documentation/security pages. | **Planned (v0.2.1). Not part of v0.1.2.** | (none — new) |
| **Flow 6 — Mermaid Diagram Generation** | Generate a corrected Mermaid DFD from extracted facts as a review aid. Original input diagram stays separate. | **Planned. Not part of v0.1.2.** | (none — new) |
| **Flow 7 — Plugin Install UX** | Repo-local evaluation today; clean install/load UX planned for v0.1.3 onward. | **Planning underway.** | (none — new) |
| Out of scope | AISRAF would act without human gates. | **Out of scope.** | AL5 |

**Important.** "Runtime evidence" (Flow 2 / internal AM3 / AL3) is **not** the same as "executing the chain against your design package." Flow 2 proves that the orchestrator's handoff, run-state, and event log are well-formed when invoked through a local smoke run. The everyday review work is **Flow 1 (Local Orchestrated Review)**.

## Section 11 — Stakeholder Views

Read the document that matches your role first; then come back here for the architectural map.

| Stakeholder | Start here | Then read |
|---|---|---|
| **New evaluator** | [`docs/AISRAF-PRIMER.md`](AISRAF-PRIMER.md) | This guide, then [`docs/OPERATOR-QUICKSTART.md`](OPERATOR-QUICKSTART.md). |
| **Security architect** | [`docs/SECURITY-REVIEW-WORKFLOW.md`](SECURITY-REVIEW-WORKFLOW.md) | Sections 3–6 of this guide, then the relevant prompt cards under `prompts/rs/` and `prompts/dfd/`. |
| **Application / solution architect** | [`docs/OPERATOR-QUICKSTART.md`](OPERATOR-QUICKSTART.md) | Sections 5, 7, 8 of this guide. |
| **Maintainer** | [`docs/ARCHITECTURE-OVERVIEW.md`](ARCHITECTURE-OVERVIEW.md) and [`../RELEASE-MANIFEST.yaml`](../RELEASE-MANIFEST.yaml) | This guide, plus `validation/no-drift-rules.md`, the BP-12C report set under `validation/`, and the five validators in Section 9. |
| **Contributor** | [`../CONTRIBUTING.md`](../CONTRIBUTING.md) and [`../FOLDER-CONTRACTS.md`](../FOLDER-CONTRACTS.md) | Sections 2–6 of this guide, `validation/no-drift-rules.md`, and the relevant Build Package checklists under `validation/`. |
| **Founder / release decision maker** | [`../README.md`](../README.md) and [`../LICENSE`](../LICENSE) | This guide's Sections 1, 10, 11, plus [`docs/ROADMAP.md`](ROADMAP.md) and [`../RELEASE-MANIFEST.yaml`](../RELEASE-MANIFEST.yaml). |

## Section 12 — Visual Index

The first public visual pack lives under [`../diagrams/release-v0.1.2/`](../diagrams/release-v0.1.2/) and is registered in [`../diagrams/diagram-registry.yaml`](../diagrams/diagram-registry.yaml). Use these visuals to orient yourself before reading the prompt cards and skill contracts.

| ID | Title | File |
|---|---|---|
| V-00 | AISRAF Customer Story Flow | [`../diagrams/release-v0.1.2/png/V-00-AISRAF-Customer-Story-Flow.png`](../diagrams/release-v0.1.2/png/V-00-AISRAF-Customer-Story-Flow.png) |
| V-02 | AISRAF Package Map / Read Order | [`../diagrams/release-v0.1.2/png/V-02-AISRAF-Package-Map-Read-Order.png`](../diagrams/release-v0.1.2/png/V-02-AISRAF-Package-Map-Read-Order.png) |
| V-03 | Stakeholder Reading Path | [`../diagrams/release-v0.1.2/png/V-03-Stakeholder-Reading-Path.png`](../diagrams/release-v0.1.2/png/V-03-Stakeholder-Reading-Path.png) |
| V-04 | Evidence Pack vs Capability Roadmap vs Drift Baseline | [`../diagrams/release-v0.1.2/png/V-04-Evidence-Pack-vs-Capability-Roadmap-vs-Drift-Baseline.png`](../diagrams/release-v0.1.2/png/V-04-Evidence-Pack-vs-Capability-Roadmap-vs-Drift-Baseline.png) |
| V-10 | DFD Annotation Legend Card | [`../diagrams/release-v0.1.2/png/V-10-DFD-Annotation-Legend-Card.png`](../diagrams/release-v0.1.2/png/V-10-DFD-Annotation-Legend-Card.png) |
| V-11 | Annotated DFD Example | [`../diagrams/release-v0.1.2/png/V-11-Annotated-DFD-Example.png`](../diagrams/release-v0.1.2/png/V-11-Annotated-DFD-Example.png) |
| M1-CTX | Mode 1 Local Review Context | [`../diagrams/release-v0.1.2/png/M1-CTX-Mode-1-Local-Review-Context.png`](../diagrams/release-v0.1.2/png/M1-CTX-Mode-1-Local-Review-Context.png) |
| M1-DFD | Mode 1 Input to Output DFD | [`../diagrams/release-v0.1.2/png/M1-DFD-Mode-1-Input-to-Output-DFD.png`](../diagrams/release-v0.1.2/png/M1-DFD-Mode-1-Input-to-Output-DFD.png) |
| M1-SEQ | Mode 1 Operator Run Sequence | [`../diagrams/release-v0.1.2/png/M1-SEQ-Mode-1-Operator-Run-Sequence.png`](../diagrams/release-v0.1.2/png/M1-SEQ-Mode-1-Operator-Run-Sequence.png) |
| M2-FLOW | Mode 2 Runtime Evidence Flow | [`../diagrams/release-v0.1.2/png/M2-FLOW-Mode-2-Runtime-Evidence-Flow.png`](../diagrams/release-v0.1.2/png/M2-FLOW-Mode-2-Runtime-Evidence-Flow.png) |
| M3-FLOW | Mode 3 Commit Gate Flow | [`../diagrams/release-v0.1.2/png/M3-FLOW-Mode-3-Commit-Gate-Flow.png`](../diagrams/release-v0.1.2/png/M3-FLOW-Mode-3-Commit-Gate-Flow.png) |
| M4-BND | Mode 4 Future Boundary and Non-Claim | [`../diagrams/release-v0.1.2/png/M4-BND-Mode-4-Future-Boundary-and-Non-Claim.png`](../diagrams/release-v0.1.2/png/M4-BND-Mode-4-Future-Boundary-and-Non-Claim.png) |
| V-23 | Release Package Structure | [`../diagrams/release-v0.1.2/png/V-23-Release-Package-Structure.png`](../diagrams/release-v0.1.2/png/V-23-Release-Package-Structure.png) |
| V-24 | Validation Ladder | [`../diagrams/release-v0.1.2/png/V-24-Validation-Ladder.png`](../diagrams/release-v0.1.2/png/V-24-Validation-Ladder.png) |
| V-25 | Publication and License Boundary | [`../diagrams/release-v0.1.2/png/V-25-Publication-and-License-Boundary.png`](../diagrams/release-v0.1.2/png/V-25-Publication-and-License-Boundary.png) |

---

**Closing posture.** AISRAF v0.1.2 is a **public source-available evaluation-only proof-of-concept**. It is **not open source**, **not production software**, and **not marketplace-published**. It performs **no current external adapter execution** (no Jira / Confluence / Lucidchart / Rovo / MCP / cloud / database / Terraform / event bus / telemetry / post-back), **no current online threat-intelligence execution**, and **no current Mermaid generation feature**. Connected Review Flow (Flow 4, v0.2.0), Threat Intelligence Enrichment (Flow 5, v0.2.1), and Mermaid Diagram Generation (Flow 6) are planned and gated by explicit later work-packages. **Closed-loop autonomy is out of scope.**
