# Build Package 12C — Proposed File Tree

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_AND_ALIGNMENT_REFERENCE**. This document began as the BP12C planning tree and now also records the WP-12C-K1B-A authority interpretation. Provider projection surfaces listed below are active where already authored; the future `plugins/` surface remains gated and must not be created until validator allow-list updates pass.

## Conventions

- `[NEW]` = file authored by BP12C-Implementation at the time this planning tree was created.
- `[ACTIVE]` = file or folder already authored by an accepted WP-12C gate.
- `[FUTURE-GATED]` = future path that must not exist until a later validator gate authorizes it.
- `[SURGICAL]` = existing file modified narrowly by BP12C-Implementation (allow-list extension, synopsis update).
- `[SEALED]` = existing file unchanged.
- All template placeholders use `{{run_id}}`, never hard-coded `RUN-001`.

## Work Package Naming And Adapter Strategy

Build Package IDs remain the internal execution and validation IDs. Work Package names are the human-facing names used in status, validation closeout, commit planning, and practical-guide references:

| Work Package ID | Friendly Name | Technical BP ID |
|---|---|---|
| WP-12B | Post-Execution Governance Closure | BP12B |
| WP-12C | Operator Experience Foundation | BP12C |
| WP-12C-D | Adapter & Provider Discovery Alignment | BP12C-D |
| WP-12C-E | Interactive Operator Test Harness | BP12C-E |
| WP-12C-F | Cross-Provider Runtime Adapter Strategy | BP12C-F |
| WP-13 | Diagram & Release View Pack | BP13 |

Adapter principle: **Define once, project many.** Canonical authority remains with registries, PRAs, prompts, skills, templates, catalogs, blueprints, run profiles, validation, and `tools/Test-*.ps1`. Projection/adapters remain `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `tools/hooks/`, Claude local projection if needed, future Microsoft Agent Framework adapter, future Azure AI Foundry deployment adapter, and future Google ADK adapter.

GitHub Copilot / VS Code is the current operator-experience priority. Microsoft Agent Framework is the primary future runtime adapter target. Azure AI Foundry is the primary future hosted implementation/deployment target. Google ADK remains optional and future. Claude remains useful as a local/provider projection but is not the blocking priority.

No projection file becomes source of truth; no adapter duplicates canonical logic; no hook silently generates review content; no runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure AI Foundry execution is claimed without evidence.

## Planning Surface (BP12C-Planning, this step — already authored)

```
validation/
  package-12c-operator-experience-plan.md          [NEW]   ← umbrella plan
  agent-skill-projection-checklist.md              [NEW]   ← wrapper gates
  hook-readiness-checklist.md                      [NEW]   ← hook gates
  role-smoke-test-checklist.md                     [NEW]   ← role smoke gates
  chat-preview-test-checklist.md                   [NEW]   ← chat preview gates
  package-12c-proposed-file-tree.md                [NEW]   ← this file (optional)
tools/
  Test-AisrafPackage.ps1                           [SURGICAL: Check 11 allow-list +6 filenames; synopsis text]
```

No other file is touched by BP12C-Planning.

## Implementation Surface (WP-12C projection surface, active where accepted)

WP-12C-H resolves the provider skill layout: Copilot-discoverable Agent Skills live under `.github/skills/<skill-id>/SKILL.md`. The existing `.copilot-skills/` files remain local/operator wrapper projections and are not the provider package format.

```
.copilot-skills/                                   [ACTIVE — local/operator projection]
  README.md                                        [EXISTING] ← discovery + reference index
  aisraf-orchestration.skill.md                    [EXISTING] ← thin projection of .agents/aisraf-orchestrator.agent.md
  aisraf-input-read.skill.md                       [EXISTING] ← thin projection of .agents/aisraf-input-reader.agent.md
  aisraf-dfd-extraction.skill.md                   [EXISTING] ← thin projection of .agents/aisraf-dfd-extractor.agent.md
  aisraf-review-table-build.skill.md               [EXISTING] ← thin projection of .agents/aisraf-review-table-builder.agent.md
  aisraf-blueprint-questioning.skill.md            [EXISTING] ← thin projection of .agents/aisraf-blueprint-questioner.agent.md
  aisraf-finding-recommendation.skill.md           [EXISTING] ← thin projection of .agents/aisraf-finding-recommender.agent.md
  aisraf-handoff-qa-score.skill.md                 [EXISTING] ← thin projection of .agents/aisraf-handoff-qa-scorer.agent.md
  aisraf-orchestration.operator-card.md            [EXISTING] ← co-located operator card (one per wrapper)
  aisraf-input-read.operator-card.md               [EXISTING]
  aisraf-dfd-extraction.operator-card.md           [EXISTING]
  aisraf-review-table-build.operator-card.md       [EXISTING]
  aisraf-blueprint-questioning.operator-card.md    [EXISTING]
  aisraf-finding-recommendation.operator-card.md   [EXISTING]
  aisraf-handoff-qa-score.operator-card.md         [EXISTING]

.github/skills/                                    [ACTIVE — WP-12C-H provider projection]
  aisraf-orchestration/SKILL.md                    [NEW] ← provider Agent Skill package
  aisraf-input-read/SKILL.md                       [NEW]
  aisraf-dfd-extraction/SKILL.md                   [NEW]
  aisraf-review-table-build/SKILL.md               [NEW]
  aisraf-blueprint-questioning/SKILL.md            [NEW]
  aisraf-finding-recommendation/SKILL.md           [NEW]
  aisraf-handoff-qa-score/SKILL.md                 [NEW]

.github/hooks/                                     [ACTIVE — WP-12C-H provider projection]
  aisraf-guardrails.json                           [NEW] ← provider hook config calling tools/hooks/*.ps1

tools/hooks/                                       [ACTIVE — reusable hook implementation]
  README.md                                        [EXISTING] ← hook contract index
  aisraf-allowed-path-prewrite-guard.ps1           [EXISTING] ← block-only, no file authoring
  aisraf-focused-validator-postwrite.ps1           [EXISTING] ← validate-only
  aisraf-session-stop-summary.ps1                  [EXISTING] ← chat-summary-only
  aisraf-precommit-full-validator.ps1              [EXISTING] ← runs Test-AisrafBp12AReadiness verbatim
  hook-allow-list.yaml                             [EXISTING] ← single source of truth read by the prewrite guard

validation/                                        [planned future authors, not BP12C-Planning scope]
  package-12c-controlled-output-checklist.md       [NEW in BP12C-Impl] ← Test layer 4
  package-12c-regression-checklist.md              [NEW in BP12C-Impl] ← Test layer 5
  package-12c-operator-card-usability-checklist.md [NEW in BP12C-Impl] ← Test layer 6

tools/
  Test-AisrafPackage.ps1                           [SURGICAL: Check 11 allow-list +3 filenames (controlled-output, regression, operator-card-usability); Check 12 tools allow-list +5 hook scripts; synopsis update]
  Test-AisrafBp12AReadiness.ps1                    [SURGICAL: add 7-wrapper byte-stability check, 4-hook block-only check; allowed-tracked-drift list extension]

.claude/                                           [GIT-EXCLUDED, BP12A check claude-excluded enforces]
  settings.json                                    [NEW LOCAL — wires the 4 hooks; not staged]
  hooks/                                           [NEW LOCAL DIR — symlinks/calls to tools/hooks/*.ps1]
```

## Future Plugin Surface (WP-12C-K2+, gated and not authored)

`plugins/` is the future top-level projection packaging surface. It is intentionally absent at WP-12C-K1B-A and remains blocked until WP-12C-K1B-B validator allow-list updates pass.

```
plugins/                                           [FUTURE-GATED — do not create in K1B-A]
  aisraf-copilot-plugin/                           [FUTURE-GATED — K2 scaffold only after validator allow-list passes]
    README.md                                      [FUTURE-GATED]
    PLUGIN-PACKAGING-PLAN.md                       [FUTURE-GATED]
    PLUGIN-TEST-CARD.md                            [FUTURE-GATED]
    EVIDENCE-CHECKLIST.md                          [FUTURE-GATED]
    plugin.yaml                                    [FUTURE-GATED]
    agents/                                        [FUTURE-GATED — bundled by reference from .github/agents/]
    skills/                                        [FUTURE-GATED — bundled by reference from .github/skills/ and .copilot-skills/]
    hooks/                                         [FUTURE-GATED — bundled by reference from tools/hooks/ and .github/hooks/]
    prompts/                                       [FUTURE-GATED — bundled by reference from prompts/]
    skills-canonical/                              [FUTURE-GATED — bundled by reference from skills/]
    templates/                                     [FUTURE-GATED — bundled by reference from templates/]
    catalogs/                                      [FUTURE-GATED — bundled by reference from catalogs/]
    blueprints/                                    [FUTURE-GATED — bundled by reference from blueprints/]
    validation/                                    [FUTURE-GATED — evidence templates only until WP-12C-L]
    evidence/                                      [FUTURE-GATED — filled only by install validation]
    tools/                                         [FUTURE-GATED — bundled by reference from tools/]
    registries/                                    [FUTURE-GATED — bundled by reference from canonical registries]
```

No file under future `plugins/` becomes canonical source of truth, and no plugin install or external execution claim is allowed before WP-12C-L evidence exists.

## Sealed (Unchanged by BP12C-Implementation)

The following surfaces are **read-only** for BP12C-Implementation. Any byte-change is a stop condition.

```
prompts/                                           [SEALED]
skills/                                            [SEALED — no canonical rewrite]
prototype-agents/                                  [SEALED]
.agents/                                           [SEALED]
.github/agents/                                    [SEALED — projection]
catalogs/                                          [SEALED]
blueprints/                                        [SEALED]
templates/                                         [SEALED]
samples/                                           [SEALED — beyond BP10A/BP12B-approved baseline refresh]
config/                                            [SEALED]
runs/RUN-001/inputs/                               [SEALED]
runs/RUN-001/run-profile.yaml                      [SEALED]
runs/RUN-001/00-run-log.md                         [SEALED — BP12B post-execution evidence]
runs/RUN-001/01-..-17-*.md                         [SEALED — BP12B post-execution evidence]
runs/RUN-001/dfd/.gitkeep                          [SEALED]
runs/RUN-001/dfd/01-..-09-*.md                     [SEALED — BP12B post-execution evidence]
diagrams/                                          [SEALED until BP13]
docs/                                              [SEALED until BP14]
release/                                           [SEALED until BP15]
authoring-agents/                                  [SEALED]
PACKAGE-MANIFEST.yaml                              [SURGICAL IN K1B-A — authority status only; no plugin scaffold]
```

## Cardinality Summary

| Layer | Count |
|---|---|
| Local/operator skill wrappers | 7 |
| Provider Agent Skills packages | 7 |
| Operator cards | 7 |
| Lifecycle hooks | 4 |
| Provider hook config | 1 |
| Hook allow-list YAML | 1 |
| Hook README + skills README | 2 |
| Future validation checklists (BP12C-Impl) | 3 |
| Surgical tool edits | 2 (`Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`) |
| Total NEW provider files in WP-12C-H | 7 Agent Skill `SKILL.md` files + 1 hook JSON = **8** |
| Total SURGICAL edits in BP12C-Impl | **2** |

## Risk Notes

- **Allow-list growth**: BP12C-Impl extends the `tools/Test-AisrafPackage.ps1` Check 11 (validation/) and Check 12 (tools/) allow-lists. Both extensions are surgical and reversible.
- **`.claude/` exclusion**: Hook wiring under `.claude/settings.json` is **not staged** and remains operator-local; the BP12A check `claude-excluded` continues to enforce this.
- **Q1 Q2 dependency**: Implementation cannot begin until Q1 (skill wrapper canonical location) and Q2 (hook host) are answered. Other Qs can be deferred but are easier to resolve up front.
- **Future runtime adapter split**: BP12C-F records Microsoft Agent Framework as the primary future runtime adapter target and Azure AI Foundry as the primary future hosted implementation/deployment target. Google ADK remains optional and future; no runtime adapter is implemented by this file.
- **BP13 coordination**: BP12C-Impl runs in parallel to BP13 readiness. If BP13 starts first, the wrappers will not yet exist; that is acceptable — the canonical adapters are sufficient for BP13 work.

## Acceptance Verdict (this file)

**Informational.** This file is non-binding. Acceptance is by §Open Founder Questions answers in the umbrella plan.
