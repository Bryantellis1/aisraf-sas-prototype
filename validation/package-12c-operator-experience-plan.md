# Build Package 12C — Operator Experience, Skill Projection, Hooks, and Test Harness Alignment Plan

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. No skill wrappers, hooks, or settings files are created by this checklist. Implementation is gated on explicit founder approval of this plan.

## Identity

- Gate category: Operator-experience package (planning phase).
- Run order position: between BP12B (Post-Execution Governance Closure) and BP13 (Diagrams).
- Owning Build Package: 12C.
- Founder approval required: explicit, on this document and the four sub-checklists, before any wrapper, hook, or settings file is created.

## Work Package Naming Convention

Build Package IDs remain the internal execution, validation, package-order, and traceability identifiers. Work Package names are the human-facing names used for status, validation closeout, commit planning, and practical-guide references. Future references must carry both together, for example `BP12C-D / WP-12C-D -- Adapter & Provider Discovery Alignment`.

## Work Package Register

| Work Package ID | Friendly Name | Technical BP ID | Purpose | Current Status | Primary User/Audience | Canonical Assets | Projection Assets | Test Evidence | Next Gate |
|---|---|---|---|---|---|---|---|---|---|
| WP-12B | Post-Execution Governance Closure | BP12B | Close the executed RUN-001 chain and approved baseline/evidence posture. | closed evidence floor | founder, reviewer, package maintainer | run profiles, validation, tools/Test-*.ps1, RUN-001 evidence | none beyond governed run evidence | BP12B validator pass and sealed RUN-001 evidence | WP-12C implementation and adapter checks |
| WP-12C | Operator Experience Foundation | BP12C | Make AISRAF usable by people through agent/skill/hook/operator-card surfaces. | implementation surface present; validation in progress | local operator, founder, reviewer | registries, PRAs, prompts, skills, templates, catalogs, validation, tools/Test-*.ps1 | .agents/, .github/agents/, .copilot-skills/, tools/hooks/ | package and BP12A validators plus hook smoke | WP-12C-D/E closeout |
| WP-12C-D | Adapter & Provider Discovery Alignment | BP12C-D | Confirm Local, GitHub Copilot, Claude, and future provider projection behavior. | validation pass pending founder commit | operator, adapter maintainer | registries, prompt-skill-agent mapping, validation, tools/Test-*.ps1 | .agents/, .github/agents/, .copilot-skills/, tools/hooks/, Claude local projection if needed | BP12A adapter projection checks and git hygiene | WP-12C-E harness closeout |
| WP-12C-E | Interactive Operator Test Harness | BP12C-E | Prove chat-preview, role-smoke, hook, validator, and controlled-output test paths. | static harness pass; manual interactive run pending | operator, founder, reviewer | validation checklists, run profiles, templates, tools/Test-*.ps1 | wrappers, operator cards, hooks | role smoke, chat preview, hook smoke, validator ladder; controlled output only on approved scratch run | WP-12C-F strategy confirmation |
| WP-12C-F | Cross-Provider Runtime Adapter Strategy | BP12C-F | Define future adapter targets for Microsoft Agent Framework, Azure AI Foundry, Google ADK, and Claude without implementing runtime execution yet. | strategy only; no runtime execution claimed | architect, future runtime implementer | registries, PRAs, prompts, skills, templates, catalogs, validators | future Microsoft Agent Framework adapter, future Azure AI Foundry deployment adapter, Google ADK future adapter, Claude local projection | design review and no-fake-proof validation | WP-13 after D/E/F closeout and founder approval |
| WP-13 | Diagram & Release View Pack | BP13 | Generate final framework/package diagrams only after WP-12C-D/E are closed. | next allowed by manifest when gates are satisfied; not started here | founder, reviewer, release reader | diagrams contract, validation, templates, package manifest | future diagram and release-view projections | diagram readiness gate and package validators | BP13 diagram authoring approval |

## Purpose

Complete the practical operator layer so AISRAF is a usable, testable, repeatable Copilot/Claude-style workflow — not just canonical Markdown contracts. Specifically:

1. Project the 7 approved adapters into Copilot-discoverable thin **skill wrappers** that reference (never rewrite) canonical skills, prompts, templates, and validators.
2. Add conservative **lifecycle hooks** that block, validate, or summarize — never generate content silently.
3. Author **operator-experience instructions** for each wrapper so a non-author practitioner can run, interpret, and stop a review.
4. Define a layered **test harness** that proves discovery, role smoke, chat preview, controlled output, scoring regression, operator-card usability, and (deferred) bring-your-own-DFD intake.

## Adapter Strategy Principle

**Define once, project many.** Canonical truth stays in `skill-registry.yaml`, `prompt-registry.yaml`, `prototype-agent-registry.yaml`, `validation/prompt-skill-agent-mapping-checklist.md`, `prototype-agents/`, `prompts/`, `skills/`, `templates/`, `catalogs/`, run profiles, `validation/`, and `tools/Test-*.ps1`. Provider-specific surfaces are projections only: `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `tools/hooks/`, Claude local projection if needed, future Microsoft Agent Framework adapter, future Azure AI Foundry deployment adapter, and future Google ADK adapter.

GitHub Copilot / VS Code remains the current operator-experience priority. Microsoft Agent Framework is the primary future runtime adapter target. Azure AI Foundry is the primary future hosted implementation/deployment target. Google ADK remains in scope as a future optional adapter, not removed. Claude remains a useful local/provider projection, but it is not the blocking priority for BP12C commit readiness.

No projection file becomes the source of truth. No adapter duplicates canonical logic. No hook silently generates review content. No runtime, cloud, Jira, Confluence, MCP, ADK, Microsoft Agent Framework, Azure AI Foundry, Google ADK, Claude, database, Terraform, release, or external post-back execution is claimed without evidence and explicit package authorization.

## Observed Gap (Trigger)

The Agent Customizations UI showed AISRAF custom agents (`.github/agents/aisraf-*.agent.md`) but only built-in skills and no AISRAF lifecycle hooks. The root cause is that the earlier `.copilot-skills/*.skill.md` files were flat local/operator wrappers, not Agent Skills packages. WP-12C-H repairs this by adding `.github/skills/<skill-id>/SKILL.md` packages and `.github/hooks/*.json` provider hook config while retaining `.copilot-skills/` and `tools/hooks/` as reusable projections.

## Out-of-Scope (Hard Pins)

BP12C does **not**:

- Rewrite or modify any canonical skill (`skills/rs/SK-*.md`, `skills/dfd/SK-DFD-0[1-9]-*.md`).
- Modify any prompt, PRA, adapter, catalog, blueprint, template, sample input, or expected baseline.
- Modify any RUN-001 generated output, run-profile, or run-log.
- Modify any blueprint match logic, scoring rubric, or AI Action Level mapping.
- Author diagrams, runbooks, release artifacts, or sample-002.
- Generate content silently from hooks. Hooks block, validate, or summarize.
- Make external calls (Jira, Confluence, MCP, ADK, Microsoft Agent Framework, Azure AI Foundry, runtime, cloud, database, Terraform).
- Author skill wrappers or hooks during the **planning phase**. Implementation is a separate, explicitly-approved step.

## Phase Split

| Phase | Allowed | Forbidden |
|---|---|---|
| 12C-Planning (this step) | Author the 5 plan/checklist files in `validation/` and the optional file-tree document; surgical extension of `tools/Test-AisrafPackage.ps1` Check 11 allow-list and synopsis to host the new validation files. | Authoring any skill wrapper file, hook script, settings file, or operator card. |
| 12C-Implementation (deferred) | Author 7 thin skill wrapper files; author 4 lifecycle hooks; author 7 operator cards; extend `tools/Test-AisrafPackage.ps1` and `tools/Test-AisrafBp12AReadiness.ps1` allow-lists for the new surfaces. | Rewriting any canonical artefact; silent content generation from hooks; external execution claims. |

## Skill Projection Set (7 Wrappers)

Each wrapper is a thin Copilot-native projection of an existing canonical adapter and the canonical skills/prompts/templates that adapter owns. Each wrapper REFERENCES — does not duplicate — the canonical contract.

| # | Wrapper ID | Wraps Canonical Adapter | Canonical PRA | Canonical Skills Referenced | Canonical Prompts Referenced |
|---|---|---|---|---|---|
| 1 | `aisraf-orchestration` | `.agents/aisraf-orchestrator.agent.md` | `prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md` | none (orchestration owns no skill) | `prompts/rs/00-run-full-chain.prompt.md` |
| 2 | `aisraf-input-read` | `.agents/aisraf-input-reader.agent.md` | `prototype-agents/PRA-02-INPUT-READER.md` | `skills/rs/SK-INPUT-PACKAGE-READ.md` | `prompts/rs/01-input-package-read.prompt.md` |
| 3 | `aisraf-dfd-extraction` | `.agents/aisraf-dfd-extractor.agent.md` | `prototype-agents/PRA-03-DFD-EXTRACTOR.md`, `prototype-agents/PRA-04-LEGEND-NORMALIZER.md` | `skills/rs/SK-DFD-VISUAL-READ.md`, `skills/rs/SK-LEGEND-NORMALIZE.md`, `skills/rs/SK-COMPONENT-EXTRACT.md`, `skills/rs/SK-FLOW-EXTRACT.md`, `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`, `skills/dfd/SK-DFD-0[1-9]-*.md` | `prompts/rs/02-dfd-visual-read.prompt.md`, `prompts/rs/03-legend-normalization.prompt.md`, `prompts/rs/04-design-fact-extract.prompt.md`, `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/dfd/02-dfd-intake-quality-check.prompt.md` through `prompts/dfd/10-dfd-extraction-summarize.prompt.md` |
| 4 | `aisraf-review-table-build` | `.agents/aisraf-review-table-builder.agent.md` | `prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md` | `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`, `skills/rs/SK-SECURITY-STACK-ASSESS.md`, `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md` | `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/rs/06-review-table-build.prompt.md` |
| 5 | `aisraf-blueprint-questioning` | `.agents/aisraf-blueprint-questioner.agent.md` | `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md` | `skills/rs/SK-MISSING-FACT-IDENTIFY.md`, `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md`, `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md`, `skills/rs/SK-TARGETED-QUESTION-GENERATE.md` | `prompts/rs/07-missing-fact-question-generate.prompt.md`, `prompts/rs/08-ai-action-level-classify.prompt.md`, `prompts/rs/09-blueprint-match.prompt.md` |
| 6 | `aisraf-finding-recommendation` | `.agents/aisraf-finding-recommender.agent.md` | `prototype-agents/PRA-07-FINDING-RECOMMENDER.md` | `skills/rs/SK-FINDING-CLASSIFY.md`, `skills/rs/SK-RECOMMENDATION-WRITE.md` | `prompts/rs/10-finding-recommendation-write.prompt.md` |
| 7 | `aisraf-handoff-qa-score` | `.agents/aisraf-handoff-qa-scorer.agent.md` | `prototype-agents/PRA-08-HANDOFF-QA-SCORER.md` | `skills/rs/SK-HANDOFF-PACK-BUILD.md`, `skills/rs/SK-VALIDATION-NOTE-WRITE.md`, `skills/rs/SK-ACCURACY-SCORE.md` | `prompts/rs/11-handoff-pack-build.prompt.md`, `prompts/rs/12-validation-note-write.prompt.md`, `prompts/rs/13-accuracy-score.prompt.md` |

## Lifecycle Hook List (4 Hooks)

Every hook is **block / validate / summarize only**. None generates content silently. Each hook fires on a defined event, runs a defined narrow check, and returns one of `PASS`, `FAIL`, or `SUMMARY` — never authors, mutates, or commits.

| # | Hook ID | Event | Behavior | Validator / Artifact Referenced |
|---|---|---|---|---|
| 1 | `aisraf-allowed-path-prewrite-guard` | Prewrite (before any AISRAF wrapper writes a file) | Block any write whose target path is not on the active build-package allow-list (current: `runs/RUN-001/` chain outputs and the BP12C planning surface). FAIL → write is refused; PASS → write proceeds. | `tools/Test-AisrafPackage.ps1` Check 08i, BP12B post-execution allow-list. |
| 2 | `aisraf-focused-validator-postwrite` | Postwrite (after a wrapper completes a write) | Run the narrow validator that owns the touched surface (e.g., `Test-AisrafRunProfile.ps1` for `runs/RUN-001/run-profile.yaml`; Check 08i logic for `runs/RUN-001/dfd/*.md`). FAIL → loud surface; PASS → silent. | `tools/Test-AisrafRunProfile.ps1`, `tools/Test-AisrafPackage.ps1` (focused subsection). |
| 3 | `aisraf-session-stop-summary` | Session stop / agent stop | Emit a short summary: which wrapper ran, which inputs were read, which outputs were written, which validators were invoked, which stop conditions were hit. No file writes. Output goes to operator chat, not the workspace. | None (read-only). |
| 4 | `aisraf-precommit-full-validator` | Precommit (before `git commit`) | Run the full BP12A readiness harness (which itself runs `Test-AisrafPackage.ps1` and `Test-AisrafRunProfile.ps1`). FAIL → commit aborted; PASS → commit proceeds. | `tools/Test-AisrafBp12AReadiness.ps1`. |

## Operator-Experience Instruction Surface (per Wrapper)

Each wrapper carries a fixed Instruction Surface. Every instruction is falsifiable.

| # | Instruction Surface Section | Falsifiable Requirement |
|---|---|---|
| 1 | **Role explanation** | One paragraph (≤120 words) stating what this wrapper is, what it is not, and which canonical PRA owns it. |
| 2 | **What / Why / How output explanation** | Each declared output path is annotated with `What:` (1 sentence shape), `Why:` (1 sentence purpose), and `How:` (1 sentence pointing to the canonical prompt + skill that produced it). |
| 3 | **No fake proof** | Explicit prohibition: do not claim runtime / cloud / ADK / MCP / Jira / Confluence / Rovo / database / Terraform / external post-back / AAL-L4 autonomous execution. The Test-AisrafBp12AReadiness `Test-PositiveExecutionClaim` regex set is the falsifier. |
| 4 | **Preserve unknowns** | Required unknown-handling behavior (carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, `match=unknown`); never invent values to clear the field. Falsifiable by grep against canonical catalog values in any output. |
| 5 | **Stop conditions** | Each wrapper lists at least 3 stop conditions copied verbatim from its canonical adapter §11 Stop Conditions. Falsifiable by adapter byte-equality on §11 lines. |
| 6 | **Show output paths** | Each wrapper lists exact output file path(s) it is allowed to write under `runs/{{run_id}}/`. Paths are template-style (`{{run_id}}`), not hard-coded to `RUN-001`. |
| 7 | **Plain-language guide voice** | Operator-card language is short sentences, no jargon used without a 1-line definition, and no Markdown table wider than 5 columns. Falsifiable by line-length audit (≤140 chars per line) and column count. |

## Test Harness Ladder (7 Layers)

Each layer is run-able by a future BP12C-Implementation step. Layers 1–4 are **must-pass** for BP12C-Implementation to close; layer 5 is must-pass for BP13 to be authorized; layer 6 is best-effort; layer 7 is deferred to a later BP.

| # | Layer | Purpose | Owning Checklist | Pass Criterion |
|---|---|---|---|---|
| 1 | Customization discovery test | Confirm Copilot/Claude UI lists the 7 wrappers and the 4 hooks register on the right events. | `validation/agent-skill-projection-checklist.md` (gates D1–D7), `validation/hook-readiness-checklist.md` (gates D1–D4). | All 7 wrappers and 4 hooks visible/registered. |
| 2 | Role smoke test | Confirm each wrapper, when selected with no input, emits its role explanation and refuses to write. | `validation/role-smoke-test-checklist.md` (gates R1–R7). | 7 PASS / 0 FAIL. |
| 3 | Chat preview test | Confirm each wrapper, given the RUN-001 inputs, previews canonical output shape without writing files. | `validation/chat-preview-test-checklist.md` (gates P1–P7). | 7 PASS / 0 FAIL; `Get-UnauthorizedRunOutputs` unchanged before/after. |
| 4 | Controlled output generation test | Re-execute the BP12B chain with the new wrappers active; bytes of the 26 generated outputs must match the BP12B baseline (or be diffed for explicit founder approval). | (BP12C-Impl) `validation/package-12c-controlled-output-checklist.md` *— planned, not authored in 12C-Planning.* | 26 SHA-256 matches OR explicit founder-approved diff. |
| 5 | Scoring / regression test | `runs/RUN-001/17-accuracy-score.md` retains `PASS_READY_FOR_REVIEW`; expected-baselines remain byte-stable; package and BP12A validators stay 0 FAIL. | (BP12C-Impl) `validation/package-12c-regression-checklist.md` *— planned, not authored in 12C-Planning.* | 0 regression. |
| 6 | Operator-card usability test | Founder reads each operator card cold and can predict input / output / stop behavior without opening canonical skills. | (BP12C-Impl) `validation/package-12c-operator-card-usability-checklist.md` *— planned.* | Founder verdict: PASS. |
| 7 | Bring-your-own-DFD intake test | Operator supplies a non-sample-001 DFD and the chain produces a governed `runs/RUN-002/` fixture. | Deferred to BP12D or post-BP13. | Deferred. |

## Allowed Planning Writes (this step only)

```
validation/package-12c-operator-experience-plan.md      [NEW]
validation/agent-skill-projection-checklist.md          [NEW]
validation/hook-readiness-checklist.md                  [NEW]
validation/role-smoke-test-checklist.md                 [NEW]
validation/chat-preview-test-checklist.md               [NEW]
validation/package-12c-proposed-file-tree.md            [NEW, optional]
tools/Test-AisrafPackage.ps1                            [SURGICAL: Check 11 allow-list extended by 6 filenames; synopsis text updated to mention BP12C planning]
```

No other write is authorized by this planning step.

## Forbidden Surfaces (this step and the deferred 12C-Implementation step)

- `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/` — canonical SoT, never rewritten.
- `samples/sample-001-dfd-crop/inputs/`, `samples/sample-001-dfd-crop/expected/` — sealed; baseline refresh is BP10A/BP12B-scoped only.
- `runs/RUN-001/inputs/`, `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/dfd/.gitkeep` — sealed.
- `runs/RUN-001/00-run-log.md`, `runs/RUN-001/01-..-17-*.md`, `runs/RUN-001/dfd/01-..-09-*.md` — sealed BP12B post-execution evidence; not regenerated by BP12C.
- `config/`, `diagrams/`, `docs/`, `release/` — sealed.
- `.github/agents/` — sealed projection (BP06; byte-identical to `.agents/`).
- `.claude/` — git-excluded; BP12A check `claude-excluded` enforces.

## Open Founder Questions (require answer before BP12C-Implementation)

- **Q1 — Skill wrapper canonical location.** Resolved by WP-12C-H: provider-discoverable skills live under `.github/skills/<skill-id>/SKILL.md`; `.copilot-skills/*.skill.md` is retained as the local/operator wrapper projection.
- **Q2 — Hook host.** Resolved by WP-12C-H: provider hook config lives under `.github/hooks/*.json`; reusable PowerShell implementation remains under `tools/hooks/`.
- **Q3 — Wrapper file shape.** Markdown with YAML front matter (matching the `.agent.md` pattern) vs. pure YAML. Recommendation: Markdown with YAML front matter for editability and discoverability.
- **Q4 — Operator card location.** Co-located with each wrapper (`.copilot-skills/aisraf-<id>.operator-card.md`) vs. unified under `docs/operator-cards/`. Recommendation: co-located; `docs/` is sealed pre-BP14.
- **Q5 — Test layer 4 (controlled output) tolerance.** Strict byte-identity vs. founder-reviewed diff. Recommendation: strict byte-identity for the 26 outputs (BP12B is the floor); diffs require explicit founder approval.

## Validation Commands (this planning step)

In order, after the 6 plan files and the surgical Check 11 allow-list extension land:

1. `pwsh -NoProfile -File tools/Test-AisrafPackage.ps1` → expect 0 FAIL, 0 regression (allow-list extended by exactly the 6 BP12C planning filenames).
2. `pwsh -NoProfile -File tools/Test-AisrafBp12AReadiness.ps1` → expect 0 FAIL (the 6 new validation files are untracked until staged; `tools/Test-AisrafPackage.ps1` modification is on the BP12A approved-drift list).
3. `pwsh -NoProfile -File tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` → expect 12 PASS, 0 FAIL (unchanged; BP12C does not touch the run profile).
4. `git status` → deltas only inside the BP12C planning allowed-writes set.

## Stop Conditions (this planning step)

- Any FAIL from any of the three validators above.
- Any modification to a forbidden surface.
- Any author of a skill wrapper, hook script, settings file, or operator card during the planning step.
- Any silent content generation by a hook (planning or implementation).
- Any external execution claim added by any planning artefact.

## Acceptance Verdict (planning step)

**PASS** when: 6 plan files exist; the surgical allow-list extension is the only `tools/` change; all three validators are 0 FAIL; git status shows deltas only inside the planning allowed-writes set; founder reviews and approves the four sub-checklists below.

## BP13 Coordination

BP12C planning does **not** unblock or block BP13. BP13 (Diagrams) is gated on BP12-SAMPLE-DFD-BLOCKER resolution (resolved by BP10A + BP11A) and is currently `next_allowed`. BP12C-Planning runs in parallel to BP13 readiness; BP12C-Implementation should land *before or alongside* BP13 so operators can drive BP13 work with the projected wrappers, but BP13 may proceed first if the founder elects.

## WP-12C-L Lifecycle Status (Operator-Experience Surface)

| Gate | Status | Note |
|---|---|---|
| WP-12C-L0 | BLACK / CLOSED | Install readiness preflight passed. |
| WP-12C-L1 | BLACK / CLOSED | Local plugin install test completed. |
| WP-12C-L1A | BLACK / CLOSED | Provider install surface patch (`plugin.json`) completed; no MCP / external execution / post-back enabled. |
| WP-12C-L2A | BLACK / CLOSED with UX caveat | Installed preview-only role smoke ran from the isolated smoke workspace `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`; all 7 AISRAF roles responded preview-only; Finding Recommender output interleaved (UX caveat only — not functionally wrong). Final status `WP-12C-L2A_PREVIEW_ROLE_SMOKE_PASS_READY_FOR_UX_FIX`. |
| WP-12C-L2A-UX | NEXT | Operator usability, evidence capture, and manual runbook patch — documentation-only. Workspace guidance, UI / provider explanation, terminal posture, role-smoke runbook, L2B readiness rules, future-integration boundary, and Git hygiene. Detailed in `validation/package-12c-plugin-install-and-publication-checklist.md` §20. |
| WP-12C-L2B | BLOCKED | Controlled-output smoke. Blocked until L2A-UX accepted, run path chosen, scratch folder approved, prewrite guard and focused validator commands specified. No `RUN-001` or `samples` writes permitted. |
| WP-12C-L3 | BLOCKED | Install evidence + Git staging decision. First gate that may decide staging or publication. The known `runs/RUN-SMOKE-LOCAL-001/` package validator WARN must be cleared at this gate. |
| WP-13 | BLOCKED | Diagram & release view pack. Blocked until L3 closes. |

### L2A-UX Documentation Surface Map

| Topic | Authoritative Doc |
|---|---|
| Workspace guidance | `validation/package-12c-plugin-install-and-publication-checklist.md` §20.1; `validation/package-12c-manual-operator-test-guide.md` §15; `validation/package-12c-quick-manual-test-card.md` "Workspace Guidance". |
| UI / provider explanation | install-checklist §20.2; manual-operator-test-guide §17. |
| Terminal / evidence capture | install-checklist §20.3; manual-operator-test-guide §16; quick-manual-test-card "Terminal And Evidence Capture". |
| L2A role-smoke runbook | `validation/role-smoke-test-checklist.md` "L2A Role-Smoke Runbook"; install-checklist §20.4. |
| L2B controlled-output readiness | install-checklist §20.5. |
| Future integration boundary | install-checklist §20.6. |
| Git / version-control hygiene | install-checklist §20.7. |
