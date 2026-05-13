# AISRAF Operator Quickstart

> **Public language note.** The legacy `Mode 0/1/2/3/4` numbered list is retired for public use. The operator runs **AISRAF Local Orchestrated Review** (Flow 1), and AISRAF captures **observability evidence** alongside it (Flow 2). See [PRODUCT-FLOW-ROADMAP.md](PRODUCT-FLOW-ROADMAP.md) for the full product operating model. The `AM` / `AL` / `Mode N` vocabulary remains as internal architecture/evidence vocabulary in contracts, runtime files, and validation artifacts.

## Internal Autonomy Vocabulary (For Contributors Only)

- **AL means Autonomy Level:** how autonomous the user experience is (internal evidence vocabulary).
- **AM means Autonomy Mode / release evidence lane:** how AISRAF proves that autonomy capability (internal evidence vocabulary).
- **AM3 / AL3:** internal name for the local orchestrated runtime evidence path captured by Flow 2 (Run Observability / Runtime Evidence).
- **AM4 / AL4:** internal name for the future external-adapter/post-back capability covered by Flow 4 (planned Connected Review Flow).
- **AL5:** closed-loop autonomy; out of scope.

| Field | Value |
|---|---|
| Document | docs/OPERATOR-QUICKSTART.md |
| Source draft | validation/package-12c-operator-quickstart-draft.md |
| Promoted by | WP-12C-REL0-B — Public Release Docs |
| Release | AISRAF v0.1.2 |
| Current claim | AM3 / AL3 local orchestrated multi-agent runtime evidence is proven |
| External execution | not claimed; no live Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, or post-back execution in v0.1.2 |

## 1. Start Here

AISRAF v0.1.2 is a local security architecture review workbench. The operator runs **AISRAF Local Orchestrated Review** (Flow 1) and AISRAF captures **observability evidence** (Flow 2) alongside it. Start by previewing roles, expected reads/writes, run profile, and stop conditions. Confirm what each role reads, what it may write during an approved controlled-output gate, and what it must not claim. Do not write files until the controlled-output gate is explicitly approved.

The day-to-day operator workflow: one selected agent session (typically `@aisraf-orchestrator`) walks the operator through the chain sequentially. AISRAF captures observability evidence alongside the review — run-state, event log, specialist handoff records (internal AM3-01 through AM3-06 representation), human gate records, and validation results. This is an evidence-path claim, not a claim of full specialist-generated review output execution, production readiness, publication, or Connected Review Flow (Flow 4 / internal AM4) integration.

Release flow status (operator-facing):

| Flow | Operator meaning |
|---|---|
| Local Orchestrated Review (Flow 1) | Normal security architect / application architect path. The operator approves local Markdown writes under an approved run folder. Optional "preview-first" step lets you inspect roles, expected inputs, planned outputs, run profile, and stop conditions without writes. |
| Run Observability (Flow 2) | Captured alongside Flow 1. Records orchestrator-owned run-state, event log, specialist handoff records, human gate records, and validation result summary as local evidence (`00-run-log.md`, `runtime/run-state.yaml`, `runtime/events.ndjson`, or equivalent governed names). v0.1.2 emits this evidence today through the local runtime evidence harness; the target product experience is for the orchestrator to auto-emit during Flow 1. Not a separate operator mode. |
| Release QA Flow (Flow 3) | Maintainer-only path for package validation, bundle checksum validation, release manifests, blocker registers, and QA reports. Operators do not run this. |
| Connected Review Flow (Flow 4) | Planned for v0.2.0. No Jira, Confluence, Lucidchart, Rovo/MCP, cloud, database, Terraform, event bus, telemetry, or post-back execution occurs in v0.1.2. |
| Threat Intelligence Enrichment (Flow 5) | Planned for v0.2.1. Not implemented in v0.1.2. |
| Mermaid Diagram Generation (Flow 6) | Planned. Generates a corrected Mermaid DFD as a review aid; original input diagram stays separate. Not implemented in v0.1.2. |
| Plugin Install UX (Flow 7) | Repo-local evaluation today; clean install/load UX planned for v0.1.3 onward. |

Closed-loop autonomy is out of scope.

## 1a. Two User Journeys In Plain English

### Application architect / solution architect — pre-review

1. Create a run folder with `tools/New-AisrafRun.ps1`.
2. Add the DFD/source diagram, legend, design notes, intake notes, and transcript or questionnaire under `runs/<run_id>/inputs/`.
3. Start with `@aisraf-orchestrator`.
4. Get back: missing facts, internal review table, targeted questions, suggested controls (drawn from blueprints and catalogs), and corrected-diagram guidance.
5. Use those outputs to improve the design package before formal security review.

### Security architect — review

1. Receive the staged design package.
2. Stage it under a personal `runs/<run_id>/inputs/`.
3. Use `@aisraf-orchestrator` to run the review chain.
4. Review the extracted components, flows, trust boundaries, data classifications, authentication / authorization annotations, encryption-in-transit notes, and storage / at-rest protection.
5. Produce findings, recommendations, handoff pack, validation notes, and an accuracy score where eligible.
6. Keep unknowns visible. Every unanswered question must surface as `Unknown`, `Not Stated`, or `Deferred` and feed `09-missing-facts.md` and `12-targeted-questions.md`.

Public users do **not** "run AM3." Public users run an **AISRAF Local Orchestrated Review**, and AISRAF captures observability evidence alongside the run. `AM3` / `AL3` remains **internal** vocabulary used in contracts, runtime files, and validation artifacts.

## Local Orchestrated Review Visual Map

These diagrams show the Local Orchestrated Review operator journey (Flow 1). They do not claim external adapter execution, marketplace publication, production operation, Connected Review Flow (Flow 4) execution, or closed-loop autonomy.

![M1-CTX Mode 1 Local Review Context showing human actors, local workstation/provider surface, AISRAF controlled processing, local evidence, and future adapter targets.](../diagrams/release-v0.1.2/png/M1-CTX-Mode-1-Local-Review-Context.png)

![M1-SEQ Mode 1 Operator Run Sequence showing local setup, run-profile validation, orchestrator use, local outputs, and no external adapter execution.](../diagrams/release-v0.1.2/png/M1-SEQ-Mode-1-Operator-Run-Sequence.png)

![M1-DFD Mode 1 Input-to-Output DFD showing local user, provider surface, AISRAF processing, local stores, and future targets excluded from current execution.](../diagrams/release-v0.1.2/png/M1-DFD-Mode-1-Input-to-Output-DFD.png)

## 2. Install And Discovery Expectation

For the public GitHub proof-of-concept, clone or download the repository and open the repository folder in VS Code. The AISRAF v0.1.2 package is delivered from the repository folder under `plugins/aisraf-copilot-plugin/`. Discovery happens through your local/provider surface (VS Code Local plugin list, GitHub Copilot agent dropdown, or Copilot CLI) from the repository package surface, not through marketplace publication. v0.1.2 is not marketplace-published.

License posture: public source-available evaluation-only proof-of-concept. Not open source. Not production software. Local Orchestrated Review (Flow 1) is the everyday user path; Run Observability / Runtime Evidence (Flow 2) is captured alongside it. No Connected Review Flow adapter execution (Flow 4 / internal AM4) in v0.1.2. No Jira, Confluence, Lucidchart, Rovo/MCP, cloud, database, Terraform, event bus, telemetry, or external post-back execution in v0.1.2. No Threat Intelligence Enrichment (Flow 5) in v0.1.2. Closed-loop autonomy is out of scope.

Once the local/provider surface loads the package, the operator should see:

- 7 AISRAF agents: `@aisraf-orchestrator`, `@aisraf-input-reader`, `@aisraf-dfd-extractor`, `@aisraf-review-table-builder`, `@aisraf-blueprint-questioner`, `@aisraf-finding-recommender`, `@aisraf-handoff-qa-scorer`.
- 7 provider Agent Skills packages under `.github/skills/<name>/SKILL.md` (loaded through the agents).
- 1 provider hook config (`.github/hooks/aisraf-guardrails.json`) declaring `PreToolUse`, `PostToolUse`, and `Stop` events.

## 3. Two Local Workspaces You May See

- **Public POC checkout** = the cloned/downloaded GitHub repository. Use this workspace for the first-run scaffold, local inputs, run-profile validation, and local Markdown outputs.
- **Maintainer smoke workspace** = a clean installed-plugin UX proof workspace used by maintainers. Empty state is expected there until a maintainer stages local inputs; it proves installed-plugin discovery without relying on workspace-local customization folders.

Opening a governed repo file inside a separate smoke VS Code window does not make that file part of the smoke workspace.

## 4. Run-Profile Variables

Each review run is controlled by a `run-profile.yaml` under the run folder. The reference shapes are:

- `runs/RUN-001/run-profile.yaml` — governed fixture, do not mutate.
- `config/run-profile.template.yaml` — template for new runs.
- `config/run-profile.sample.folder-first.yaml` — folder-first sample.
- `config/run-profile.sample.integration.yaml` — sample showing future integration fields (deferred adapters; not active in v0.1.2).

Key fields:

- `run_id` — the run folder name under `runs/<run_id>/`.
- `inputs` — local input file paths under `runs/<run_id>/inputs/`.
- `outputs` — output destination is always local Markdown under the run folder.
- `output_destination_mode` — `local_only` in v0.1.2; integration modes are deferred.
- `external_execution` — must be `false` in v0.1.2.
- `sensitive_data_confirmed_redacted` — operator must affirm sensitive-data redaction.

The evidence ledger is `runs/<run_id>/00-run-log.md`. Inputs live under `runs/<run_id>/inputs/`. Generated outputs are the root `01` through `17` Markdown files plus `dfd/01` through `dfd/09`.

Use a separate `runs/<run_id>/` folder for each separate DFD or review. Do not reuse `runs/RUN-001/`; it is the governed fixture.

Validate any run profile with:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/<run_id>/run-profile.yaml -ExecutionReady
```

## 5. Local Folder-First Operation

v0.1.2 operates in folder-first-only mode. Every input is a local file. Every output is a local Markdown file under the approved run folder. Run Observability (Flow 2) is local-only, human-gated, validator-backed, and evidence-bound. AISRAF does not contact Jira, Confluence, Lucidchart, Rovo/MCP, cloud, databases, Terraform, event buses, or telemetry backends. There is no post-back execution. Connected Review Flow (Flow 4) is planned for v0.2.0; it is not active in v0.1.2.

### Target Observability Artifact Set Per Run

Every orchestrated run should eventually produce, under the run folder:

- `00-run-log.md` — operator-readable run log.
- `runtime/run-state.yaml` — current step, completed steps, pending steps, gate state (or an equivalent governed run-state file).
- `runtime/events.ndjson` — append-only event log of orchestrator events, handoff request/response pairs, gate request/decision events, and terminal events (or an equivalent governed event log).
- Handoff records — the internal AM3-01 through AM3-06 specialist handoff representation (internal vocabulary).
- Human gate records — operator approvals, deferrals, rejections.
- Validation result summary — the validator ladder results for the run profile and (where applicable) the AM3 runtime validators.

**v0.1.2 reality.** v0.1.2 includes a local runtime evidence harness (`tools/Invoke-AisrafAm3LocalRun.ps1` + `tools/Test-AisrafAm3Runtime.ps1`). The accepted smoke evidence lives under local-only `runs/RUN-SMOKE-AM3-001/runtime/` and is internal. The target product experience is for this evidence to be produced **automatically** during Local Orchestrated Review of a personal run folder. v0.1.2 does not yet auto-emit that evidence from the orchestrator into every personal run folder.

If a run profile attempts to enable an external integration field, the run-profile validator fails closed.

## 6. First-Run Journey (Preview Mode First)

1. Clone or download the public GitHub proof-of-concept repository.
2. Open the repository folder in VS Code.
3. Confirm the AISRAF local/provider surface appears. **Start with `@aisraf-orchestrator`.**
4. Create a personal run folder with the sample inputs:

```powershell
pwsh -NoProfile -File ./tools/New-AisrafRun.ps1 -RunId RUN-MY-REVIEW-001 -SampleId sample-001-dfd-crop -CopySampleInputs
```

5. Place or review DFD/design inputs under `runs/RUN-MY-REVIEW-001/inputs/`.
6. Edit `runs/RUN-MY-REVIEW-001/run-profile.yaml`; set `sensitive_data_confirmed_redacted: true` only after confirming inputs are redacted.
7. Validate the run profile:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-MY-REVIEW-001/run-profile.yaml -ExecutionReady
```

8. Ask what the orchestrator reads and writes, then run preview mode first. No file should change during preview.
9. Use this orchestrator prompt for the local controlled-output run: `Run a local folder-first AISRAF review using runs/RUN-MY-REVIEW-001/run-profile.yaml. Do not use external adapters. Write outputs only under runs/RUN-MY-REVIEW-001/.`
10. Review local Markdown outputs under `runs/RUN-MY-REVIEW-001/`; keep the run folder as local evidence/work product.
11. Do not use `runs/RUN-001/` for personal reviews; it is the governed fixture.
12. For another DFD or review, create another `runs/<run_id>/` folder and repeat the same local input, run-profile, validation, and output pattern.

If any role writes during preview, claims external execution, mutates `RUN-001`, mutates `samples/`, or makes a live integration claim, stop and record the gap.

## 7. Security Architect Path

A security architect uses AISRAF as a local review assistant on a received design package:

1. Stage inputs locally (DFD image or Mermaid source, legend, design notes, intake ticket text, triage notes, transcript) under `runs/<run_id>/inputs/`.
2. Start with `@aisraf-orchestrator` from the local/provider surface.
3. Walk the chain sequentially through specialist roles to produce: input inventory (`01`), visible DFD facts (`02`), legend normalization (`03`), components and flows (`04`–`05`), boundaries and security-stack assessment (`06`–`07`), internal review table (`08`), missing facts (`09`), AI Action Level classification from the governed catalog (`10`), blueprint match (`11`), targeted questions (`12`), findings (`13`), recommendations (`14`), handoff pack (`15`), validation notes (`16`), and accuracy score where eligible (`17`).
4. Review unknowns and evidence. Findings must trace to evidence. Recommendations must trace to findings and to blueprint/question context.
5. Hand off the local Markdown outputs to your usual review channels. There is no automated post-back to Jira, Confluence, or any external system in v0.1.2.

## 8. Application / Solution Architect Path

An application or solution architect can use AISRAF locally as a shift-left lint pass over their own design package before formal security review:

1. Self-check the DFD locally. Confirm that data classifications, source/destination, trust-boundary crossings, authentication and authorization signals, encryption in transit and at rest, and confidence level are visible — or flagged as Unknown.
2. Use the missing-facts output (`09-missing-facts.md`) to name the design questions security review will ask. Answer them before the meeting, not during it.
3. Use the review-table draft (`08-internal-review-table.md`) and targeted questions (`12-targeted-questions.md`) to update the design package before submitting to security review.
4. No external integrations are needed. Everything stays local.

## 9. What Not To Do

- Do not run `git add .`.
- Do not stage `.claude/`.
- Do not stage `runs/RUN-SMOKE-*/` folders.
- Do not edit `runs/RUN-001/`.
- Do not edit `samples/`.
- Do not edit `catalogs/`, `blueprints/`, `templates/`, `prompts/`, `skills/`, `prototype-agents/`, or `config/` without an approved work package.
- Do not claim Run Observability / Runtime Evidence (Flow 2 / internal AM3 / AL3) beyond the accepted local evidence path.
- Do not claim Connected Review Flow (Flow 4 / internal AM4 / AL4) or closed-loop autonomy as current.
- Do not claim live Jira, Confluence, Lucidchart, MCP, Foundry, ADK, MAF, database, Terraform, cloud runtime, event bus, telemetry backend, or external post-back execution.
- Do not claim live Threat Intelligence Enrichment (Flow 5) — `SKL-THREAT-INTEL-CURRENT-CONTEXT` is planned for v0.2.1 and is not implemented in v0.1.2.

## 10. Validator Ladder

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

All three must return 0 FAIL before any contribution or staging activity.

## 11. Cross-Shell Command Snippets

The validator commands above are written for **PowerShell 7 (`pwsh`)** because that is the shell tested by the gate. The same scripts can be invoked from **Windows PowerShell (`powershell.exe`)** and from **Git Bash invoking `powershell.exe`**, but cross-shell command parity is **not yet validated by an automated gate**. The cross-shell command UX is covered by the next gate (`WP-12C-REL0-CROSS-SHELL-COMMAND-UX`).

```powershell
# PowerShell 7 / pwsh (validator-tested shell)
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

```powershell
# Windows PowerShell / powershell.exe (cross-shell parity is planned; not yet validated)
powershell.exe -NoProfile -File .\tools\Test-AisrafPackage.ps1
powershell.exe -NoProfile -File .\tools\Test-AisrafRunProfile.ps1 -RunProfilePath .\runs\RUN-001\run-profile.yaml -ExecutionReady
```

```bash
# Git Bash invoking powershell.exe (cross-shell parity is planned; not yet validated)
powershell.exe -NoProfile -File ./tools/Test-AisrafPackage.ps1
powershell.exe -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

Do not assume Windows PowerShell or Git Bash invocations match the `pwsh` baseline until the cross-shell gate explicitly validates them.
