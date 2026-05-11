# Build Package 12C - Operator Quickstart Draft

| Field | Value |
|---|---|
| Work package | WP-12C-PRIMER0 / WP-12C-ED1 - Public Repository Primer And Security Architect Journey Draft (ED1 readability pass applied) |
| Status | Pre-release public-reader draft; validation-owned; not promoted to docs or release |
| Audience | Security architect, solution architect, application/product team, engineering team, governance/reviewer, contributor/maintainer, public technical reader/evaluator |
| Boundary | Local-first, preview-first, controlled-output only after approval |
| Current maturity | AL2 controlled-output local workbench; AL3 orchestrated multi-agent runtime is future WP-ORCH |
| Release posture | Not public-release-ready; L3, REL0, and WP-13 remain blocked |

## 1. Start Here

AISRAF is currently a strong pre-release prototype / local workbench package operating at autonomy level AL2 (controlled-output local workbench). Start in preview mode. Confirm what each role reads, what it may write during an approved controlled-output gate, what stops it, and what it must not claim. Do not write files until the controlled-output gate is explicitly approved.

A true orchestrated multi-agent runtime (AL3) is a future WP-ORCH track, not v0.1.2 behavior. Current execution is one selected agent session acting as a temporary orchestrator that walks the operator through the chain sequentially. The plugin packages that orchestrator together with the specialist agents, skill wrappers, and hook scripts so the operator can install one thing.

Use this draft as a reader journey, not as release documentation. Public docs promotion happens later under the docs/release gate.

## 2. Required Workspace Model

- `AISRAF-PLUGIN-SMOKE-WORKSPACE` = clean installed-plugin UX proof.
- `AISRAF- SAS Prototype v0.1.2` = governed repo/package source.
- `validation/` = test cards, QA specs, readiness docs, PRIMER0 drafts.
- `plugins/aisraf-copilot-plugin/` = plugin package.
- `samples/` = canonical fixture, do not mutate.
- `runs/RUN-001/` = governed fixture, do not mutate.
- `runs/RUN-SMOKE-PLUGIN-L2B-001/` = future controlled-output scratch run.
- `catalogs/` = controlled vocabulary.
- `blueprints/` = review patterns.
- `templates/` = output formats.

The clean smoke workspace proves installed-plugin behavior. The governed repo is for package validation, draft authoring, and git hygiene. Do not run installed-plugin product proof from the governed repo workspace, because local projection folders can contaminate discovery.

Operator workspace note: `AISRAF-PLUGIN-SMOKE-WORKSPACE` may be empty by design; that empty workspace proves installed-plugin behavior without workspace-local contamination. `AISRAF- SAS Prototype v0.1.2` is the governed repo and package source. Opening a governed repo file inside the smoke VS Code window does not make that file part of the smoke workspace. The run variable/control file is `runs/<run_id>/run-profile.yaml`, the evidence ledger is `runs/<run_id>/00-run-log.md`, inputs live under `runs/<run_id>/inputs/`, and generated outputs are the root `01` through `17` Markdown files plus `dfd/01` through `dfd/09`. For L2B retry, `runs/RUN-SMOKE-PLUGIN-L2B-001/` already exists and may only be reused after explicit approval following guard MP1 pass.

## 3. First-Run User Journey

1. Open the clean smoke workspace at `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`. An empty clean smoke workspace is expected by design until the user supplies a local input package or run folder — that empty state proves the installed plugin is loading from the plugin source or provider cache, not from workspace-local customization folders.
2. Confirm the AISRAF plugin appears through the provider surface (VS Code Local plugin list, GitHub Copilot agent dropdown, or Copilot CLI).
3. Select an AISRAF role from the installed plugin. **Users start with `@aisraf-orchestrator`.** The six specialist agents (`@aisraf-input-reader`, `@aisraf-dfd-extractor`, `@aisraf-review-table-builder`, `@aisraf-blueprint-questioner`, `@aisraf-finding-recommender`, `@aisraf-handoff-qa-scorer`) remain available for direct expert use.
4. Ask what it reads and writes.
5. Run preview mode first.
6. Do not write files until the approved controlled-output gate.
7. Use the sample DFD/design package first (`samples/sample-001-dfd-crop/inputs/`), or stage a local input package under `runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/`.
8. Review output expectations before any controlled write.
9. Confirm no external execution claim appears (no Jira, Confluence, Lucidchart, MCP, cloud runtime, database, Terraform, or post-back execution).

In preview mode, no repository file should change. If any role writes, claims external execution, mutates `RUN-001`, mutates `samples/`, or makes a live integration claim, stop and record the gap.

### 3.1 What AISRAF skills are and where they live

AISRAF skills are packaged capabilities loaded by the AISRAF agents. The current package ships them three ways:

- **Canonical skill contracts** under `skills/rs/` (17 contracts) and `skills/dfd/` (9 contracts) — these are governed Markdown specifications, not executable runtime tools.
- **Operator-facing skill wrappers and cards** under `.copilot-skills/` — 7 thin skill wrappers (`*.skill.md`) plus 7 operator cards (`*.operator-card.md`).
- **Provider Agent Skills packages** under `.github/skills/<name>/SKILL.md` — 7 folder-based packages mirrored byte-identically inside the plugin bundle.

Skills load through agents by default. If the provider's Copilot Skills UI lists only built-ins, that is a provider-UI presentation choice — the AISRAF skills are still installed and reachable through `@aisraf-orchestrator` and the specialist agents. Skill packaging is validated by `Test-AisrafPackage.ps1` checks `08a`, `08a1`, and `16b`.

## 4. Role Preview Prompts

Use these prompts one role at a time. Capture the response and confirm no files changed.

### AISRAF Orchestrator

```text
ROLE PREVIEW. Selected role: AISRAF Orchestrator. Preview only. Write nothing. State your role identity, reads, theoretical writes, stop conditions, expected output, unknown handling, and prohibited claims. Do not modify RUN-001. Do not claim runtime, cloud, Jira, Confluence, Lucidchart, MCP, database, Terraform, release, or post-back execution.
```

### AISRAF Input Reader

```text
ROLE PREVIEW. Selected role: AISRAF Input Reader. Preview only. Write nothing. Explain how you inventory the local design package, what inputs you can read, what output shape you would use, how you handle missing inputs, and what you must not claim. Do not modify RUN-001 or samples.
```

### AISRAF DFD Extractor

```text
ROLE PREVIEW. Selected role: AISRAF DFD Extractor. Preview only. Write nothing. Explain DFD visible-object extraction, legend normalization, component extraction, flow extraction, DFD subchain outputs, unknown preservation, and prohibited claims. Do not generate diagrams or infer implementation proof.
```

### AISRAF Review Table Builder

```text
ROLE PREVIEW. Selected role: AISRAF Review Table Builder. Preview only. Write nothing. Explain boundaries, security-stack assessment, internal review table output, evidence rules, stop conditions, and prohibited claims. Do not claim controls are implemented from labels alone.
```

### AISRAF Blueprint Questioner

```text
ROLE PREVIEW. Selected role: AISRAF Blueprint Questioner. Preview only. Write nothing. Explain missing facts, AI Action Level catalog use, blueprint match by governed registry, targeted questions, unknown handling, and prohibited claims. Do not enumerate or invent catalog values or blueprint states.
```

### AISRAF Finding Recommender

```text
ROLE PREVIEW. Selected role: AISRAF Finding Recommender. Preview only. Write nothing. Explain how findings and recommendations stay tied to evidence, missing facts, blueprint/question context, and parent traceability. Do not invent owners, controls, implementation proof, or external post-back.
```

### AISRAF Handoff QA Scorer

```text
ROLE PREVIEW. Selected role: AISRAF Handoff QA Scorer. Preview only. Write nothing. Explain handoff pack, validation notes, scoring eligibility, expected baselines, stop conditions, and prohibited claims. Do not compute or imply a numeric score unless scoring gates are met.
```

## 5. What Success Looks Like

- Each role explains identity, reads, writes, stop conditions, expected output, unknown handling, and prohibited claims.
- No files change in preview.
- No Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, or post-back claim appears.
- Validator baseline remains green.
- `RUN-001`, `samples/`, catalogs, blueprints, templates, prompts, skills, prototype agents, and projections remain unchanged.

## 6. What Not To Do

- No `git add .`.
- No `.claude` staging.
- No smoke-folder staging.
- No edits to `RUN-001`.
- No edits to `samples`.
- No edits to `catalogs/`, `blueprints/`, `templates/`, `prompts/`, `skills/`, or agents without work-package approval.
- No public release claim.
- No docs, release, or diagram artifact creation in PRIMER0.
- No L2B execution until explicit founder approval.

## 7. Testing Path

Use these validation-owned references:

- `validation/package-12c-quick-manual-test-card.md`
- `validation/package-12c-manual-operator-test-guide.md`
- `validation/role-smoke-test-checklist.md`
- `validation/package-12c-controlled-output-checklist.md`
- `validation/package-12c-qa-agent-spec.md`
- `validation/package-12c-repository-editor-agent-spec.md`

Required validator ladder:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

## 8. Scope And Overclaim Guardrails

The quickstart may explain the plugin package and future controlled-output scratch run, but it must not claim current public release, marketplace publication, live external integrations, cloud runtime, database runtime, Terraform deployment, live MCP, Claude runtime adapter, Azure AI Foundry, Google ADK, Microsoft Agent Framework, event bus, telemetry backend, or external post-back. Future adapters must remain future/deferred/not implemented.

The quickstart must not claim AL3 orchestrated multi-agent runtime, AL4 external tool/post-back execution, or AL5 higher autonomy. Current AISRAF behavior is AL2 controlled-output local workbench only.

The public form must not include secrets, customer data, private endpoints, private links, personal paths, or sales-heavy framing.

## 9. Contributor-Safe Guidance

- Use exact path lists, never `git add .`.
- Keep `.claude/` local-only.
- Keep smoke folders out of staging.
- Do not edit canonical assets without an approved work package.
- Do not edit catalog, blueprint, template, prompt, skill, or PRA files without the approved governance lane.
- Do not mutate `runs/RUN-001/` or `samples/`.
- Do not stage smoke evidence before L3.

## 10. Definition Of Done

This quickstart draft is ready for later editor/QA review when:

- Validators return 0 FAIL.
- Catalog/blueprint governance is documented.
- Public docs are promoted later under the docs/release gate.
- L2B smoke passed before any controlled-output claim.
- `RUN-001` remains unchanged.
- `samples/` remains unchanged.
- Canonical/projection surfaces remain unchanged.
- Smoke folders are not staged.
- `.claude/` is not staged.
- QA report exists.
- ED1 report exists.
- Release manifest, license, and notice are ready before public release.
