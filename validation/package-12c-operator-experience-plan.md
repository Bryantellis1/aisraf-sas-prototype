# Build Package 12C — Operator Experience, Skill Projection, Hooks, and Test Harness Alignment Plan

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. No skill wrappers, hooks, or settings files are created by this checklist. Implementation is gated on explicit founder approval of this plan.

## Identity

- Gate category: Operator-experience package (planning phase).
- Run order position: between BP12B (Post-Execution Governance Closure) and BP13 (Diagrams).
- Owning Build Package: 12C.
- Founder approval required: explicit, on this document and the four sub-checklists, before any wrapper, hook, or settings file is created.

## Purpose

Complete the practical operator layer so AISRAF is a usable, testable, repeatable Copilot/Claude-style workflow — not just canonical Markdown contracts. Specifically:

1. Project the 7 approved adapters into Copilot-discoverable thin **skill wrappers** that reference (never rewrite) canonical skills, prompts, templates, and validators.
2. Add conservative **lifecycle hooks** that block, validate, or summarize — never generate content silently.
3. Author **operator-experience instructions** for each wrapper so a non-author practitioner can run, interpret, and stop a review.
4. Define a layered **test harness** that proves discovery, role smoke, chat preview, controlled output, scoring regression, operator-card usability, and (deferred) bring-your-own-DFD intake.

## Observed Gap (Trigger)

The Agent Customizations UI shows AISRAF custom agents (`.github/agents/aisraf-*.agent.md`) but only built-in skills and no AISRAF lifecycle hooks. This is a deferred operator-experience gap, not a BP12B validator blocker. BP12B closed all three validators green; the canonical chain executed RUN-001 successfully; the operator surface is incomplete.

## Out-of-Scope (Hard Pins)

BP12C does **not**:

- Rewrite or modify any canonical skill (`skills/rs/SK-*.md`, `skills/dfd/SK-DFD-0[1-9]-*.md`).
- Modify any prompt, PRA, adapter, catalog, blueprint, template, sample input, or expected baseline.
- Modify any RUN-001 generated output, run-profile, or run-log.
- Modify any blueprint match logic, scoring rubric, or AI Action Level mapping.
- Author diagrams, runbooks, release artifacts, or sample-002.
- Generate content silently from hooks. Hooks block, validate, or summarize.
- Make external calls (Jira, Confluence, MCP, ADK, runtime, cloud, database, Terraform).
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
| 4 | `aisraf-review-table-build` | `.agents/aisraf-review-table-builder.agent.md` | `prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md` | `skills/rs/SK-SECURITY-STACK-ASSESS.md`, `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md`, `skills/rs/SK-MISSING-FACT-IDENTIFY.md` | `prompts/rs/06-review-table-build.prompt.md`, `prompts/rs/07-missing-fact-question-generate.prompt.md` |
| 5 | `aisraf-blueprint-questioning` | `.agents/aisraf-blueprint-questioner.agent.md` | `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md` | `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md`, `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md`, `skills/rs/SK-TARGETED-QUESTION-GENERATE.md` | `prompts/rs/08-ai-action-level-classify.prompt.md`, `prompts/rs/09-blueprint-match.prompt.md` |
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

- **Q1 — Skill wrapper canonical location.** Two candidates: (A) `.copilot-skills/aisraf-*.skill.md` paralleling the `.agents/` canonical layout; (B) `.github/copilot/skills/aisraf-*.skill.md` collocated with the existing `.github/copilot-instructions.md`. Recommendation: A, with optional byte-identical projection to B mirroring the existing adapter pattern.
- **Q2 — Hook host.** Two candidates: (A) Claude Code project hooks under `.claude/hooks/` — but `.claude/` is git-excluded, so hooks would not be repo-portable; (B) tracked hooks under `tools/hooks/` invoked from `.claude/settings.json` and from a shared precommit shim. Recommendation: B for portability and validator coverage.
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
