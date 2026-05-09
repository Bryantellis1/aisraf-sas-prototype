# Build Package 12C — Proposed File Tree

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. This document proposes the file tree the **BP12C-Implementation** step would author. **No file in §Implementation Surface is created during BP12C-Planning.** The tree is a discussion artifact for founder review.

## Conventions

- `[NEW]` = file authored by BP12C-Implementation.
- `[SURGICAL]` = existing file modified narrowly by BP12C-Implementation (allow-list extension, synopsis update).
- `[SEALED]` = existing file unchanged.
- All template placeholders use `{{run_id}}`, never hard-coded `RUN-001`.

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

## Implementation Surface (BP12C-Implementation, deferred)

The **canonical wrapper** layout is the recommendation in §Open Founder Questions Q1 (option A: `.copilot-skills/`). If founder selects Q1 option B (`.github/copilot/skills/`), substitute the path uniformly.

```
.copilot-skills/                                   [NEW DIR — pending Q1 approval]
  README.md                                        [NEW] ← discovery + reference index
  aisraf-orchestration.skill.md                    [NEW] ← thin projection of .agents/aisraf-orchestrator.agent.md
  aisraf-input-read.skill.md                       [NEW] ← thin projection of .agents/aisraf-input-reader.agent.md
  aisraf-dfd-extraction.skill.md                   [NEW] ← thin projection of .agents/aisraf-dfd-extractor.agent.md
  aisraf-review-table-build.skill.md               [NEW] ← thin projection of .agents/aisraf-review-table-builder.agent.md
  aisraf-blueprint-questioning.skill.md            [NEW] ← thin projection of .agents/aisraf-blueprint-questioner.agent.md
  aisraf-finding-recommendation.skill.md           [NEW] ← thin projection of .agents/aisraf-finding-recommender.agent.md
  aisraf-handoff-qa-score.skill.md                 [NEW] ← thin projection of .agents/aisraf-handoff-qa-scorer.agent.md
  aisraf-orchestration.operator-card.md            [NEW] ← Q4 co-located operator card (one per wrapper)
  aisraf-input-read.operator-card.md               [NEW]
  aisraf-dfd-extraction.operator-card.md           [NEW]
  aisraf-review-table-build.operator-card.md       [NEW]
  aisraf-blueprint-questioning.operator-card.md    [NEW]
  aisraf-finding-recommendation.operator-card.md   [NEW]
  aisraf-handoff-qa-score.operator-card.md         [NEW]

tools/hooks/                                       [NEW DIR — pending Q2 approval]
  README.md                                        [NEW] ← hook contract index
  aisraf-allowed-path-prewrite-guard.ps1           [NEW] ← block-only, no file authoring
  aisraf-focused-validator-postwrite.ps1           [NEW] ← validate-only
  aisraf-session-stop-summary.ps1                  [NEW] ← chat-summary-only
  aisraf-precommit-full-validator.ps1              [NEW] ← runs Test-AisrafBp12AReadiness verbatim
  hook-allow-list.yaml                             [NEW] ← single source of truth read by the prewrite guard

validation/                                        [planned future authors, not BP12C-Planning scope]
  package-12c-controlled-output-checklist.md       [NEW in BP12C-Impl] ← Test layer 4
  package-12c-regression-checklist.md              [NEW in BP12C-Impl] ← Test layer 5
  package-12c-operator-card-usability-checklist.md [NEW in BP12C-Impl] ← Test layer 6

tools/
  Test-AisrafPackage.ps1                           [SURGICAL: Check 11 allow-list +3 filenames (controlled-output, regression, operator-card-usability); Check 12 tools allow-list +5 hook scripts; synopsis update]
  Test-AisrafBp12AReadiness.ps1                    [SURGICAL: add 7-wrapper byte-stability check, 4-hook block-only check; allowed-tracked-drift list extension]

.github/                                           [optional Q1-B mirror surface]
  copilot/                                         [NEW DIR — only if Q1 selects option B]
    skills/                                        [NEW DIR — only if Q1 selects option B; byte-identical to .copilot-skills/]

.claude/                                           [GIT-EXCLUDED, BP12A check claude-excluded enforces]
  settings.json                                    [NEW LOCAL — wires the 4 hooks; not staged]
  hooks/                                           [NEW LOCAL DIR — symlinks/calls to tools/hooks/*.ps1]
```

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
PACKAGE-MANIFEST.yaml                              [SEALED — BP12C does not advance current_build_package; founder edits on approval]
```

## Cardinality Summary

| Layer | Count |
|---|---|
| Skill wrappers | 7 |
| Operator cards | 7 |
| Lifecycle hooks | 4 |
| Hook allow-list YAML | 1 |
| Hook README + skills README | 2 |
| Future validation checklists (BP12C-Impl) | 3 |
| Surgical tool edits | 2 (`Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`) |
| Total NEW files in BP12C-Impl | 7 + 7 + 4 + 1 + 2 + 3 = **24** |
| Total SURGICAL edits in BP12C-Impl | **2** |

## Risk Notes

- **Allow-list growth**: BP12C-Impl extends the `tools/Test-AisrafPackage.ps1` Check 11 (validation/) and Check 12 (tools/) allow-lists. Both extensions are surgical and reversible.
- **`.claude/` exclusion**: Hook wiring under `.claude/settings.json` is **not staged** and remains operator-local; the BP12A check `claude-excluded` continues to enforce this.
- **Q1 Q2 dependency**: Implementation cannot begin until Q1 (skill wrapper canonical location) and Q2 (hook host) are answered. Other Qs can be deferred but are easier to resolve up front.
- **BP13 coordination**: BP12C-Impl runs in parallel to BP13 readiness. If BP13 starts first, the wrappers will not yet exist; that is acceptable — the canonical adapters are sufficient for BP13 work.

## Acceptance Verdict (this file)

**Informational.** This file is non-binding. Acceptance is by §Open Founder Questions answers in the umbrella plan.
