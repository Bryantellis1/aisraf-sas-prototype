# AISRAF Manual Operator Test Playbook

| Field                  | Value                                                                                                                                           |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Guide name             | AISRAF Manual Operator Test Playbook                                                                                                            |
| Work package           | WP-12C-E / BP12C-E - Interactive Operator Test Harness                                                                                          |
| Status                 | Manual evidence pending; structurally validated                                                                                                 |
| Audience               | Founder, local operator, SAS reviewer, package maintainer                                                                                       |
| Purpose                | Prove the AISRAF operator experience is usable before WP-13 / BP13 diagrams begin                                                               |
| Test modes             | MODE A - Chat Preview Mode; MODE B - Controlled File Output Mode, deferred                                                                      |
| Last validation status | Test-AisrafPackage: 77 PASS, 0 WARN, 0 FAIL; Test-AisrafBp12AReadiness: 67 PASS, 0 FAIL; Test-AisrafRunProfile -ExecutionReady: 12 PASS, 0 FAIL |
| WP-13 gate status      | WP-13 / BP13 remains blocked until WP-12C-D/E manual evidence is accepted                                                                       |

Related work packages:

- WP-12C-D / BP12C-D - Adapter & Provider Discovery Alignment.
- WP-12C-F / BP12C-F - Cross-Provider Runtime Adapter Strategy.
- WP-13 / BP13 - Diagram & Release View Pack.

## Visual Legend

| Tag      | Meaning                   |
| -------- | ------------------------- |
| [BLUE]   | Goal / Context            |
| [GREEN]  | PASS criteria             |
| [YELLOW] | Caution / Watch item      |
| [RED]    | Stop / FAIL condition     |
| [PURPLE] | Evidence to capture       |
| [GRAY]   | Local-only / do not stage |

## 1. Guide Purpose And Scope

[BLUE] This guide proves AISRAF is usable before diagrams. It tests the actual operator experience: selecting agents, invoking skill wrappers, previewing output shapes, checking hooks, and confirming validators stay green.

[BLUE] This guide validates agents, skills, hooks, prompts, provider projections, and output behavior without making provider projection files authoritative. Canonical truth remains in registries, PRAs, prompts, skills, templates, catalogs, run profiles, validation, and `tools/Test-*.ps1`.

[RED] WP-13 / BP13 remains blocked until this guide is followed, manual evidence is captured, and founder acceptance is recorded. This guide does not generate diagrams, start WP-13, implement runtime adapters, or claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution.

Testing modes:

- MODE A - Chat Preview Mode: select the correct AISRAF agent, paste the guided prompt, receive chat-only output, write nothing, and verify role identity, inputs, outputs, stop conditions, and expected output shape.
- MODE B - Controlled File Output Mode: use only after explicit founder approval of a scratch run, write only to the approved scratch `output_root`, let hooks validate allowed paths, rerun validators after output, and prove `runs/RUN-001/` remains unchanged.

Common rule for every test in this guide: no file should change during Mode A. Mode B is documented as a later controlled-output test only and is not executed by this guide.

## How To Use This Guide

1. For installed-plugin product proof, open `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE` in VS Code.
2. Use the governed repo `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` for documentation edits, validators, and Git hygiene.
3. Confirm provider discovery with Section 4, using VS Code Local as the primary proof surface.
4. Run role smoke tests with Section 5.
5. Run skill wrapper tests with Section 6.
6. Run hook tests with Section 8.
7. Capture evidence in Section 11 as you go.
8. Run validators from Section 12.
9. Decide PASS, FAIL, or retry using the final gate rules in Section 14.
10. Only then consider later gates. L2B execution, L3, and WP-13 remain blocked until their explicit founder approvals are recorded.

[GRAY] Do not stage `.claude/`. Do not use `git add .`.

## 2. Work Package Map

| Work Package       | Friendly Name                           | What It Proves                                                                     | Who Uses It                           | Test Mode                | Evidence Produced                                            | Status                                          |
| ------------------ | --------------------------------------- | ---------------------------------------------------------------------------------- | ------------------------------------- | ------------------------ | ------------------------------------------------------------ | ----------------------------------------------- |
| WP-12C-D / BP12C-D | Adapter & Provider Discovery Alignment  | Provider projections are discoverable and thin.                                    | Founder, operator, adapter maintainer | Mode A                   | Discovery notes, role smoke PASS/FAIL                        | Structurally validated; manual evidence pending |
| WP-12C-E / BP12C-E | Interactive Operator Test Harness       | Operators can preview, validate, and later write only to approved scratch outputs. | Founder, operator, reviewer           | Mode A now; Mode B later | Prompt transcripts, hook command output, validator summaries | Structurally validated; manual evidence pending |
| WP-12C-F / BP12C-F | Cross-Provider Runtime Adapter Strategy | Future runtime/provider targets are named without implementation claims.           | Architect, future runtime implementer | Strategy review only     | Gap notes                                                    | Strategy only; no runtime execution             |
| WP-13 / BP13       | Diagram & Release View Pack             | Diagram work can start only after D/E evidence is accepted.                        | Founder, release reader               | Not started              | None yet                                                     | Blocked pending manual evidence                 |

## 3. Before You Start

1. Open `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` in VS Code.
2. Confirm the Local customization view shows the AISRAF agents and AISRAF skill wrappers when available.
3. Confirm GitHub Copilot / Copilot CLI projection behavior as applicable in your environment.
4. Confirm `.claude/` is local-only and is not staged.
5. Run `git status --short`.
6. Run the validators in Section 12.
7. Do not use `git add .`.
8. Do not start WP-13 / BP13.
9. Do not modify `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, or `runs/RUN-001/`.

## 4. Provider Discovery Test

### Test Card

| Field                      | Value                                                                                                                     |
| -------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| Test ID                    | D1-D6                                                                                                                     |
| Work package               | WP-12C-D / BP12C-D - Adapter & Provider Discovery Alignment                                                               |
| What you are testing       | Provider-visible surfaces can be found without becoming source of truth                                                   |
| Why it matters             | AISRAF must be practical across tools while staying governed by canonical assets                                          |
| Agent/skill/hook used      | Provider UI or local filesystem discovery; no AISRAF agent selected                                                       |
| Input / prompt / command   | Manual UI inspection plus `git status --short`                                                                          |
| Expected response shape    | Provider note naming agents, skills, hooks, instructions, prompts, MCP config, gap, blocking status, and action           |
| Files that must not change | All repository files                                                                                                      |
| Evidence to capture        | Screenshot or note, plus `git status --short` output                                                                    |
| PASS criteria              | Provider surfaces match the table, no projection duplicates canonical logic, and no runtime execution is claimed          |
| FAIL criteria              | Unknown provider files appear,`.claude/` is staged, projection files drift, or future runtime is claimed as implemented |
| Next action if PASS        | Continue to agent role smoke tests                                                                                        |
| Next action if FAIL        | Stop, record the gap, and rerun BP12A after any approved correction                                                       |

What you are testing: whether provider-facing surfaces are visible without becoming source of truth.

Why this matters: AISRAF must be practical across tools while staying governed by one canonical contract set.

| Test ID | Provider                         | What Should Be Visible                                                                                     | What May Not Be Visible                          | Blocking                                            | Founder Manual Check                                    | Smallest Action If Gap                                   |
| ------- | -------------------------------- | ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------ | --------------------------------------------------- | ------------------------------------------------------- | -------------------------------------------------------- |
| D1      | Local VS Code                    | 7 `.agents/` adapters, `.copilot-skills/`, `tools/hooks/`, workspace instructions, canonical prompts | Hook lifecycle may not auto-register in UI       | Non-blocking if files exist and validators pass     | Open Copilot Chat agent selector and customization view | Use local `.agents/` and `.copilot-skills/` directly |
| D2      | GitHub Copilot / Copilot CLI     | `.github/agents/` projections, workspace instructions, canonical prompts                                 | Skill/hook visibility may vary by client         | Non-blocking if projection files are byte-identical | Confirm AISRAF agent names appear where supported       | Keep `.github/agents/` byte-identical to `.agents/`  |
| D3      | Claude local projection          | Local `.claude/` wiring if present                                                                       | No committed Claude provider projection required | Non-blocking;`.claude/` must not be staged        | Confirm `.claude/` is local-only                      | Do not stage `.claude/`; use only if needed locally    |
| D4      | Future Microsoft Agent Framework | None yet                                                                                                   | Runtime adapter is not implemented               | Non-blocking for WP-12C-D/E                         | Verify no file claims implementation                    | Defer to WP-12C-F / BP12C-F                              |
| D5      | Future Azure AI Foundry          | None yet                                                                                                   | Hosted deployment adapter is not implemented     | Non-blocking for WP-12C-D/E                         | Verify no file claims deployment                        | Defer to WP-12C-F / BP12C-F                              |
| D6      | Future Google ADK                | None yet                                                                                                   | Optional adapter is not implemented              | Non-blocking for WP-12C-D/E                         | Verify ADK remains future only                          | Defer to WP-12C-F / BP12C-F                              |

PASS criteria: provider surfaces match the table, no projection duplicates canonical logic, and no runtime execution is claimed.

FAIL criteria: unknown provider files appear, `.claude/` is staged, projection files drift from canonical adapters, or a future runtime is claimed as implemented.

Expected result shape: a short provider-by-provider note naming visible agents, skills, hooks, instructions, prompts, MCP config status, gaps, and blocking/non-blocking status.

Files that must not change: all repository files. This is a discovery check only.

Evidence to capture: screenshot or short note listing visible agents/skills/hooks/instructions and `git status --short` output.

Next action if PASS: continue to Section 5.

Next action if FAIL: stop, record the gap, and rerun `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` after any approved correction.

## 5. Agent Role Smoke Tests

Run these in Mode A - Chat Preview Mode. Each prompt is chat-only.

Files that must not change for every role smoke test:

- `runs/RUN-001/`
- `prompts/`
- `skills/`
- `prototype-agents/`
- `catalogs/`
- `blueprints/`
- `templates/`
- `samples/`
- `.agents/`
- `.github/agents/`
- `.copilot-skills/`
- `tools/hooks/`

Expected answer shape for every role smoke test:

1. Role identity.
2. Reads.
3. Writes.
4. Stop conditions.
5. Expected output.
6. Prohibited claims.

### 5.1 AISRAF Orchestrator

- Test ID: R1.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF Orchestrator.
- Skill/operator card involved: `.copilot-skills/aisraf-orchestration.skill.md` and `.copilot-skills/aisraf-orchestration.operator-card.md`.
- What this role proves: orchestration wrapper resolves run profile and records only declared run-log output paths.
- Why this matters: the chain coordinator must not execute hidden provider/runtime behavior.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `runs/{{run_id}}/00-run-log.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF Orchestrator. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-01-SAS-REVIEW-ORCHESTRATOR`, reads the run profile, and writes only `runs/{{run_id}}/00-run-log.md` in theory.

FAIL criteria: response writes a file, edits RUN-001, claims execution, or invents downstream output.

Evidence to capture: chat response and `git status --short` after the test.

Next action if PASS: run R2.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

### 5.2 AISRAF Input Reader

- Test ID: R2.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF Input Reader.
- Skill/operator card involved: `.copilot-skills/aisraf-input-read.skill.md` and `.copilot-skills/aisraf-input-read.operator-card.md`.
- What this role proves: input inventory role can identify accepted inputs without inventing files.
- Why this matters: all downstream evidence depends on a clean input inventory.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `runs/{{run_id}}/01-input-inventory.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF Input Reader. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-02-INPUT-READER`, references `skills/rs/SK-INPUT-PACKAGE-READ.md`, and declares only `runs/{{run_id}}/01-input-inventory.md`.

FAIL criteria: response records invented inputs, claims chat attachment movement, or writes a file.

Evidence to capture: chat response and `git status --short`.

Next action if PASS: run R3.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

### 5.3 AISRAF DFD Extractor

- Test ID: R3.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF DFD Extractor.
- Skill/operator card involved: `.copilot-skills/aisraf-dfd-extraction.skill.md` and `.copilot-skills/aisraf-dfd-extraction.operator-card.md`.
- What this role proves: DFD extraction and legend normalization are projected through one adapter without duplicating canonical logic.
- Why this matters: PRA-03 and PRA-04 are intentionally consolidated here.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/` and `samples/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `02-visible-dfd-objects.md` through `05-flows.md`, plus `dfd/01-intake-quality-check.md` through `dfd/09-extraction-summary.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF DFD Extractor. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-03-DFD-EXTRACTOR` and `PRA-04-LEGEND-NORMALIZER`, references DFD skills/prompts by path, and declares outputs `02` through `05` plus `dfd/01` through `dfd/09` only.

FAIL criteria: response generates a diagram, invents DFD facts, claims runtime proof, or writes to RUN-001.

Evidence to capture: chat response and `git status --short`.

Next action if PASS: run R4.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

### 5.4 AISRAF Review Table Builder

- Test ID: R4.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF Review Table Builder.
- Skill/operator card involved: `.copilot-skills/aisraf-review-table-build.skill.md` and `.copilot-skills/aisraf-review-table-build.operator-card.md`.
- What this role proves: boundary, security-stack, and review-table outputs are owned by PRA-05.
- Why this matters: boundaries and controls must stay evidence-bound.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF Review Table Builder. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-05-REVIEW-TABLE-BUILDER`, references `06-boundaries`, `07-security-stack-assessment`, and `08-internal-review-table` as declared writes only.

FAIL criteria: response claims controls from labels alone, skips a declared output, or writes a file.

Evidence to capture: chat response and `git status --short`.

Next action if PASS: run R5.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

### 5.5 AISRAF Blueprint Questioner

- Test ID: R5.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF Blueprint Questioner.
- Skill/operator card involved: `.copilot-skills/aisraf-blueprint-questioning.skill.md` and `.copilot-skills/aisraf-blueprint-questioning.operator-card.md`.
- What this role proves: missing facts, AI Action Level, blueprint match, and targeted questions stay together under PRA-06.
- Why this matters: questions must be tied to outputs they would change.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF Blueprint Questioner. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-06-BLUEPRINT-QUESTIONER` and declares outputs `09` through `12` only.

FAIL criteria: response produces broad checklist questions, pre-accepts answers, or writes a file.

Evidence to capture: chat response and `git status --short`.

Next action if PASS: run R6.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

### 5.6 AISRAF Finding Recommender

- Test ID: R6.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF Finding Recommender.
- Skill/operator card involved: `.copilot-skills/aisraf-finding-recommendation.skill.md` and `.copilot-skills/aisraf-finding-recommendation.operator-card.md`.
- What this role proves: findings and recommendations are evidence-bound under PRA-07.
- Why this matters: recommendation quality depends on parent finding traceability.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `13-findings.md`, `14-recommendations.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF Finding Recommender. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-07-FINDING-RECOMMENDER` and declares outputs `13-findings.md` and `14-recommendations.md` only.

FAIL criteria: response invents owner/control evidence, makes implementation-proof claims, or writes a file.

Evidence to capture: chat response and `git status --short`.

Next action if PASS: run R7.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

### 5.7 AISRAF Handoff QA Scorer

- Test ID: R7.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Agent to select: AISRAF Handoff QA Scorer.
- Skill/operator card involved: `.copilot-skills/aisraf-handoff-qa-score.skill.md` and `.copilot-skills/aisraf-handoff-qa-score.operator-card.md`.
- What this role proves: handoff, validation notes, and scoring conditions are separated under PRA-08.
- Why this matters: scoring must be governed and must not hide unknowns.
- Expected response shape: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
- Files that must not change: all sealed surfaces, especially `runs/RUN-001/` and `samples/`.
- Evidence to capture: chat response and `git status --short`.
- Confirm output paths are theoretical only: `15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md`.

Copy/paste prompt:

```text
ROLE SMOKE TEST - WP-12C-E / BP12C-E. Selected role: AISRAF Handoff QA Scorer. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Read only the role adapter, operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

PASS criteria: response names `PRA-08-HANDOFF-QA-SCORER`, references scoring conditions, and declares outputs `15` through `17` only.

FAIL criteria: response claims a score without conditions, edits baselines, publishes externally, or writes a file.

Evidence to capture: chat response and `git status --short`.

Next action if PASS: continue to skill wrapper tests.

Next action if FAIL: stop, record the transcript, and do not run Mode B.

Next action if all role smoke tests PASS: continue to Section 6.

Next action if any role smoke test FAILS: stop, record the failed role, and do not run Mode B.

## 6. Skill Usage Tests

### Test Card

| Field                      | Value                                                                                                          |
| -------------------------- | -------------------------------------------------------------------------------------------------------------- |
| Test ID                    | S1-S7                                                                                                          |
| Work package               | WP-12C-E / BP12C-E - Interactive Operator Test Harness                                                         |
| What you are testing       | Skill wrappers are thin projections that point to canonical PRAs, prompts, and skills                          |
| Why it matters             | Provider-facing files must not duplicate canonical logic                                                       |
| Agent/skill/hook used      | Select the owning AISRAF agent for the wrapper under test                                                      |
| Input / prompt / command   | Paste the skill wrapper prompt pattern below                                                                   |
| Expected response shape    | Wrapper purpose, owning agent, canonical PRA paths, prompt paths, skill paths, output paths, and drift signals |
| Files that must not change | All repository files                                                                                           |
| Evidence to capture        | One chat response per wrapper or one combined transcript, plus `git status --short`                          |
| PASS criteria              | Answer references paths only and does not copy full prompt or skill bodies                                     |
| FAIL criteria              | Answer treats wrapper files as canonical, duplicates logic, adds provider-specific rules, or writes a file     |
| Next action if PASS        | Continue to prompt usage tests                                                                                 |
| Next action if FAIL        | Stop, record transcript, and do not run Mode B                                                                 |

What you are testing: skill wrappers are thin projections that point to canonical PRAs, prompts, and skills.

Why this matters: provider-facing files must not duplicate canonical logic.

Expected answer shape: wrapper purpose, owning agent, canonical PRA paths, canonical prompt paths, canonical skill paths, allowed output paths, and drift signals.

Files that must not change: all repository files. Skill wrapper tests are Mode A chat-preview tests.

Use this prompt pattern for each wrapper, replacing the wrapper ID and agent name from the table:

```text
SKILL WRAPPER TEST - WP-12C-E / BP12C-E. Wrapper ID: <wrapper-id>. Selected agent: <agent-name>. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Explain what canonical PRA, prompt paths, skill paths, templates, and allowed output paths this wrapper references. Also state what would indicate drift or duplication.
```

| Wrapper ID                        | Agent Uses It               | Canonical References To Check                                                                                                  | Answer Proves Wiring When                                     | Drift Or Duplication Signal                            |
| --------------------------------- | --------------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------- | ------------------------------------------------------ |
| `aisraf-orchestration`          | AISRAF Orchestrator         | `PRA-01`, `prompts/rs/00-run-full-chain.prompt.md`, owns no skill                                                          | It states orchestration owns no skill and writes only run log | Full prompt body copied or new skill invented          |
| `aisraf-input-read`             | AISRAF Input Reader         | `PRA-02`, `prompts/rs/01-input-package-read.prompt.md`, `skills/rs/SK-INPUT-PACKAGE-READ.md`                             | It maps to input inventory only                               | Invents requester forms or chat attachment movement    |
| `aisraf-dfd-extraction`         | AISRAF DFD Extractor        | `PRA-03`, `PRA-04`, RS DFD prompts, DFD prompt chain, RS/DFD skills                                                        | It acknowledges PRA-04 has no separate adapter                | Adds provider-specific extraction rules                |
| `aisraf-review-table-build`     | AISRAF Review Table Builder | `PRA-05`, `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/rs/06-review-table-build.prompt.md`, three RS skills | It declares outputs `06` through `08` only                | Claims controls without evidence                       |
| `aisraf-blueprint-questioning`  | AISRAF Blueprint Questioner | `PRA-06`, prompts `07` through `09`, four RS skills                                                                      | It declares outputs `09` through `12` only                | Broad checklist questions or accepted answers invented |
| `aisraf-finding-recommendation` | AISRAF Finding Recommender  | `PRA-07`, `prompts/rs/10-finding-recommendation-write.prompt.md`, two RS skills                                            | It declares outputs `13` and `14` only                    | Recommendations without parent findings                |
| `aisraf-handoff-qa-score`       | AISRAF Handoff QA Scorer    | `PRA-08`, prompts `11` through `13`, three RS skills                                                                     | It explains scoring gates before claiming scoring output      | Inflated score or baseline edits                       |

Use the table this way:

1. Select the agent in `Agent Uses It`.
2. Paste the common prompt with the wrapper ID and agent name.
3. Confirm the answer names the canonical paths only.
4. Confirm it says preview-only and write-nothing.
5. Run `git status --short` after the set.

PASS criteria: answer references paths only and does not copy full prompt or skill bodies.

FAIL criteria: answer treats wrapper files as canonical source, duplicates canonical logic, or adds provider-specific rules.

Evidence to capture: one chat response per wrapper or one combined transcript covering all seven.

Next action if PASS: continue to Section 7.

Next action if FAIL: stop, record the wrapper ID and transcript, and do not run Mode B.

## 7. Prompt Usage Tests

### Test Card

| Field                      | Value                                                                                               |
| -------------------------- | --------------------------------------------------------------------------------------------------- |
| Test ID                    | P1                                                                                                  |
| Work package               | WP-12C-E / BP12C-E - Interactive Operator Test Harness                                              |
| What you are testing       | Prompts are used by path reference only and are not copied into provider files or this guide        |
| Why it matters             | AISRAF follows define once, project many                                                            |
| Agent/skill/hook used      | Any selected AISRAF role, or repeat by role if desired                                              |
| Input / prompt / command   | Paste the prompt below                                                                              |
| Expected response shape    | Prompt path, role using it, expected template/output shape, and chat-preview/file-output capability |
| Files that must not change | All repository files, especially `prompts/` and `templates/`                                    |
| Evidence to capture        | Chat response and `git status --short`                                                            |
| PASS criteria              | Response references prompt and template paths without copying canonical prompt content              |
| FAIL criteria              | Response copies prompt bodies, invents paths, edits prompts, or claims prompt execution             |
| Next action if PASS        | Continue to hook tests                                                                              |
| Next action if FAIL        | Stop, record transcript, and do not run Mode B                                                      |

What you are testing: prompts are used as canonical chain references, not copied into provider files or this guide.

Why this matters: AISRAF follows define once, project many.

Expected answer shape: prompt path, role using it, expected template/output shape, and whether the phase is chat-preview now or file-output later.

Files that must not change: all repository files. Prompt usage tests are Mode A chat-preview tests.

Use this prompt:

```text
PROMPT USAGE TEST - WP-12C-E / BP12C-E. Preview only - write nothing. Do not modify RUN-001. Explain how the selected role uses its canonical prompt paths and expected output templates. Reference paths only. Do not copy prompt bodies. Do not claim execution.
```

| Phase               | RS Prompt                                                                                                                                                     | DFD Prompt                                                                                                          | Role That Uses It           | Expected Output Shape                                                                                                 | Capability                          |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | --------------------------- | --------------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| Orchestration       | `prompts/rs/00-run-full-chain.prompt.md`                                                                                                                    | none                                                                                                                | AISRAF Orchestrator         | `templates/output/output-00-run-log-template.md`                                                                    | Chat-preview now; file-output later |
| Input inventory     | `prompts/rs/01-input-package-read.prompt.md`                                                                                                                | none                                                                                                                | AISRAF Input Reader         | `templates/output/output-01-input-inventory-template.md`                                                            | Chat-preview now; file-output later |
| DFD visual read     | `prompts/rs/02-dfd-visual-read.prompt.md`                                                                                                                   | `prompts/dfd/02-dfd-intake-quality-check.prompt.md` through `prompts/dfd/10-dfd-extraction-summarize.prompt.md` | AISRAF DFD Extractor        | `templates/output/output-02-visible-dfd-objects-template.md` through `output-05-flows-template.md`; DFD templates | Chat-preview now; file-output later |
| Review table        | `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/rs/06-review-table-build.prompt.md`                                                             | none                                                                                                                | AISRAF Review Table Builder | `output-06` through `output-08` templates                                                                         | Chat-preview now; file-output later |
| Blueprint questions | `prompts/rs/07-missing-fact-question-generate.prompt.md`, `prompts/rs/08-ai-action-level-classify.prompt.md`, `prompts/rs/09-blueprint-match.prompt.md` | none                                                                                                                | AISRAF Blueprint Questioner | `output-09` through `output-12` templates                                                                         | Chat-preview now; file-output later |
| Findings            | `prompts/rs/10-finding-recommendation-write.prompt.md`                                                                                                      | none                                                                                                                | AISRAF Finding Recommender  | `output-13` and `output-14` templates                                                                             | Chat-preview now; file-output later |
| Handoff and score   | `prompts/rs/11-handoff-pack-build.prompt.md`, `prompts/rs/12-validation-note-write.prompt.md`, `prompts/rs/13-accuracy-score.prompt.md`                 | none                                                                                                                | AISRAF Handoff QA Scorer    | `output-15` through `output-17` templates                                                                         | Chat-preview now; file-output later |

PASS criteria: response references prompt and template paths and explains expected shape without copying canonical prompt content.

FAIL criteria: response copies full prompt bodies, invents new prompt paths, or claims a prompt executed.

Evidence to capture: selected role transcript and `git status --short`.

## 8. Hook Usage Tests

Run these commands from the repository root. These hook tests do not create files.

Files that must not change: all repository files. The sealed prompt test must block rather than modify `prompts/`.

Evidence to capture: command output, exit code where visible, and `git status --short` after the hook test set.

[YELLOW] For H2, a command-level `FAIL ... reason=not_on_allow_list` is the good outcome because the hook blocked a sealed prompt path.

### 8.1 Allowed Scratch Path PASS

- Test ID: H1.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Hook used: `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1`.
- Expected response shape: one PASS line naming the scratch target path.
- Evidence to capture: command output and `git status --short`.
- Next action if PASS: run H2.
- Next action if FAIL: stop and inspect the allow-list only after approval.

What the hook protects: output writes must land only under approved run output paths.

Why this matters: Mode B must write only to scratch output roots.

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath runs/RUN-SMOKE-LOCAL-001/01-input-inventory.md
```

PASS looks like: `PASS aisraf-allowed-path-prewrite-guard target=runs/RUN-SMOKE-LOCAL-001/01-input-inventory.md`.

FAIL looks like: any `FAIL` row for this allowed scratch path.

Failure means: the scratch output path is not currently allowed for Mode B.

When to stop: stop immediately if this path blocks, because controlled output would not be safe to run.

### 8.2 Sealed Prompt Path BLOCK

- Test ID: H2.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Hook used: `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1`.
- Expected response shape: one expected block line with `reason=not_on_allow_list`.
- Evidence to capture: command output and exit code where visible.
- Next action if PASS: run H3.
- Next action if FAIL: stop; do not run Mode B.

What the hook protects: canonical prompt files are sealed during operator testing.

Why this matters: projection tests must not rewrite canonical prompts.

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath prompts/rs/01-input-package-read.prompt.md
```

PASS looks like: expected block with `FAIL ... reason=not_on_allow_list` and exit code `1`.

FAIL looks like: the command returns a `PASS` for a sealed prompt path.

Failure means: the guard would permit a prohibited prompt edit.

When to stop: stop immediately if the prompt path passes.

### 8.3 Postwrite Focused Validator PASS

- Test ID: H3.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Hook used: `tools/hooks/aisraf-focused-validator-postwrite.ps1`.
- Expected response shape: package validator summary with `0 FAIL`, then hook PASS.
- Evidence to capture: command output and `git status --short`.
- Next action if PASS: run H4.
- Next action if FAIL: stop and record validator output.

What the hook protects: any written run output has a validator route.

Why this matters: Mode B must validate after output generation.

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-focused-validator-postwrite.ps1 -TargetPath runs/RUN-SMOKE-LOCAL-001/01-input-inventory.md
```

PASS looks like: package validator returns `0 FAIL`, followed by `PASS aisraf-focused-validator-postwrite`.

FAIL looks like: no validator route, validator missing, or validator exits nonzero.

Failure means: Mode B output would not have a focused validation route.

When to stop: stop if the hook cannot route or the validator returns nonzero.

### 8.4 Session-Stop Summary Stdout Only

- Test ID: H4.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Hook used: `tools/hooks/aisraf-session-stop-summary.ps1`.
- Expected response shape: stdout lines beginning `SUMMARY aisraf-session-stop-summary`.
- Evidence to capture: stdout summary and `git status --short`.
- Next action if PASS: run H5.
- Next action if FAIL: stop and record changed files.

What the hook protects: session summaries are visible without writing files.

Why this matters: operators need closeout context without hidden mutations.

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-session-stop-summary.ps1 -WrapperId aisraf-input-read -InputsRead runs/RUN-001/inputs -OutputsWritten none -ValidatorsInvoked tools/Test-AisrafPackage.ps1 -Status PREVIEW_ONLY
```

PASS looks like: stdout lines beginning `SUMMARY aisraf-session-stop-summary`.

FAIL looks like: files are created or modified.

Failure means: a summary hook mutated the workspace, which is not allowed.

When to stop: stop if `git status --short` shows a new change caused by this command.

### 8.5 Precommit Validator PASS

- Test ID: H5.
- Work package: WP-12C-E / BP12C-E - Interactive Operator Test Harness.
- Hook used: `tools/hooks/aisraf-precommit-full-validator.ps1`.
- Expected response shape: BP12A summary with `67 PASS, 0 FAIL`, then hook PASS.
- Evidence to capture: command output and `git status --short`.
- Next action if PASS: rerun validators in Section 12.
- Next action if FAIL: stop and fix only approved surfaces.

What the hook protects: commits must pass the full BP12A readiness harness.

Why this matters: commit readiness should not rely on memory or manual inspection alone.

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-precommit-full-validator.ps1
```

PASS looks like: `Test-AisrafBp12AReadiness: 67 PASS, 0 FAIL`, then `PASS aisraf-precommit-full-validator`.

FAIL looks like: any BP12A FAIL or hook exit code nonzero.

Failure means: commit readiness is not established.

When to stop: stop on any BP12A FAIL.

Evidence to capture for hook tests: command output and `git status --short` after the set.

## 9. Chat-Preview Test Flow

Use sample-001 / RUN-001 in Mode A only.

### Test Card

| Field                      | Value                                                                                    |
| -------------------------- | ---------------------------------------------------------------------------------------- |
| Test ID                    | C1                                                                                       |
| Work package               | WP-12C-E / BP12C-E - Interactive Operator Test Harness                                   |
| What you are testing       | Each role can preview expected output shape against RUN-001 inputs without writing files |
| Why it matters             | The workflow must be usable before controlled output is approved                         |
| Agent/skill/hook used      | Each AISRAF agent in order                                                               |
| Input / prompt / command   | Prompt below                                                                             |
| Expected response shape    | Expected output shape in chat, with canonical template paths by reference                |
| Files that must not change | All repository files, especially `runs/RUN-001/`                                       |
| Evidence to capture        | Chat transcript for each role and `git status --short`                                 |
| PASS criteria              | Output shape is visible in chat and no file changes occur                                |
| FAIL criteria              | Any file changes, execution is claimed, or shape does not match role ownership           |
| Next action if PASS        | Fill evidence worksheet                                                                  |
| Next action if FAIL        | Stop and record failed role                                                              |

1. Select the AISRAF agent for the role.
2. Paste the role smoke prompt from Section 5 or this general preview prompt:

```text
CHAT PREVIEW TEST - WP-12C-E / BP12C-E. Use sample-001 / RUN-001 inputs as read-only context. Preview only - write nothing. Do not modify RUN-001. Do not claim runtime/cloud/Jira/Confluence/MCP/ADK/Microsoft Agent Framework/Azure Foundry execution. Show the expected output shape in chat for this selected role, using canonical template paths by reference only.
```

3. Review the response against the expected answer shape.
4. Record PASS/FAIL in Section 11.
5. Run:

```powershell
git status --short
```

Expected: no changes caused by chat-preview testing.

| Step | Agent                       | Expected Shape Reference                                                                                              | PASS/FAIL |
| ---- | --------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------- |
| P1   | AISRAF Orchestrator         | `templates/output/output-00-run-log-template.md`                                                                    |           |
| P2   | AISRAF Input Reader         | `templates/output/output-01-input-inventory-template.md`                                                            |           |
| P3   | AISRAF DFD Extractor        | `templates/output/output-02-visible-dfd-objects-template.md` through `output-05-flows-template.md`; DFD templates |           |
| P4   | AISRAF Review Table Builder | `templates/output/output-06-boundaries-template.md` through `output-08-internal-review-table-template.md`         |           |
| P5   | AISRAF Blueprint Questioner | `templates/output/output-09-missing-facts-template.md` through `output-12-targeted-questions-template.md`         |           |
| P6   | AISRAF Finding Recommender  | `templates/output/output-13-findings-template.md`, `templates/output/output-14-recommendations-template.md`       |           |
| P7   | AISRAF Handoff QA Scorer    | `templates/output/output-15-handoff-pack-template.md` through `output-17-accuracy-score-template.md`              |           |

Next action if PASS: continue to hook tests or record manual evidence complete.

Next action if FAIL: stop and record the role, transcript, and file status.

## 10. Controlled File-Output Test Plan

Do not execute this section without explicit founder approval.

Approved L2B scratch run folder:

```text
runs/RUN-SMOKE-PLUGIN-L2B-001/
```

Do not use:

```text
runs/SMOKE-LOCAL-001/
```

Reason: `config/run-profile.schema.yaml` requires `run_id` to match `RUN-*`.

Planned setup command after explicit approval:

```powershell
pwsh -NoProfile -File ./tools/New-AisrafRun.ps1 -RunId RUN-SMOKE-PLUGIN-L2B-001 -SampleId sample-001-dfd-crop -CopySampleInputs
```

What gets copied: sample input files from `samples/sample-001-dfd-crop/inputs/` into `runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/`.

What must be reviewed: copied inputs, `runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml`, and the redaction flag before any output write.

Required run-profile posture:

- `run_id: "RUN-SMOKE-PLUGIN-L2B-001"`
- `sample_id: "sample-001-dfd-crop"`
- `mode: "folder_first_test"`
- `input_root: "runs/RUN-SMOKE-PLUGIN-L2B-001/inputs"`
- `expected_root: "samples/sample-001-dfd-crop/expected"`
- `output_root: "runs/RUN-SMOKE-PLUGIN-L2B-001"`
- `output_destination_mode: "local_only"`
- `postback_execution_status: "deferred"`
- `sensitive_data_confirmed_redacted: true` after operator review

Hook that validates it: `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1` allows run output paths matching `runs/[A-Z0-9][A-Z0-9-]*/...`. `tools/hooks/aisraf-focused-validator-postwrite.ps1` routes run outputs to package validation.

Before each approved output write, run:

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath <target-file>
```

After each approved output write, run:

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-focused-validator-postwrite.ps1 -TargetPath <target-file>
```

Final validator ladder for the scratch run:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady
```

Prove RUN-001 remains unchanged:

```powershell
git status --short -- runs/RUN-001
git diff --name-only -- runs/RUN-001
```

Expected: no output unless prior approved RUN-001 drift already exists. Do not proceed if RUN-001 changes during scratch testing.

Known non-blocking warning: `runs/RUN-SMOKE-LOCAL-001/` exists beside `RUN-001` and must not be removed in UXA. Keep it as an L3 cleanup / staging hygiene item and do not stage smoke folders.

## 11. Evidence Capture Sheet

| Test ID | Work Package       | Agent/Skill/Hook                  | Prompt/Command Used  | Expected Result                               | Actual Result | PASS/FAIL | Evidence Notes | Follow-Up Needed |
| ------- | ------------------ | --------------------------------- | -------------------- | --------------------------------------------- | ------------- | --------- | -------------- | ---------------- |
| D1      | WP-12C-D / BP12C-D | Local VS Code                     | Provider discovery   | 7 agents and wrappers visible where supported |               |           |                |                  |
| D2      | WP-12C-D / BP12C-D | GitHub Copilot / CLI              | Provider discovery   | Projection visible where supported            |               |           |                |                  |
| D3      | WP-12C-D / BP12C-D | Claude local projection           | Provider discovery   | `.claude/` local only, not staged           |               |           |                |                  |
| D4      | WP-12C-F / BP12C-F | Future Microsoft Agent Framework  | Strategy check       | Not implemented, no execution claim           |               |           |                |                  |
| D5      | WP-12C-F / BP12C-F | Future Azure AI Foundry           | Strategy check       | Not implemented, no deployment claim          |               |           |                |                  |
| D6      | WP-12C-F / BP12C-F | Future Google ADK                 | Strategy check       | Optional future only                          |               |           |                |                  |
| R1      | WP-12C-E / BP12C-E | AISRAF Orchestrator               | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| R2      | WP-12C-E / BP12C-E | AISRAF Input Reader               | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| R3      | WP-12C-E / BP12C-E | AISRAF DFD Extractor              | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| R4      | WP-12C-E / BP12C-E | AISRAF Review Table Builder       | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| R5      | WP-12C-E / BP12C-E | AISRAF Blueprint Questioner       | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| R6      | WP-12C-E / BP12C-E | AISRAF Finding Recommender        | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| R7      | WP-12C-E / BP12C-E | AISRAF Handoff QA Scorer          | Role smoke prompt    | Preview-only role summary                     |               |           |                |                  |
| S1      | WP-12C-E / BP12C-E | `aisraf-orchestration`          | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| S2      | WP-12C-E / BP12C-E | `aisraf-input-read`             | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| S3      | WP-12C-E / BP12C-E | `aisraf-dfd-extraction`         | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| S4      | WP-12C-E / BP12C-E | `aisraf-review-table-build`     | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| S5      | WP-12C-E / BP12C-E | `aisraf-blueprint-questioning`  | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| S6      | WP-12C-E / BP12C-E | `aisraf-finding-recommendation` | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| S7      | WP-12C-E / BP12C-E | `aisraf-handoff-qa-score`       | Skill wrapper prompt | Thin projection references only               |               |           |                |                  |
| P1      | WP-12C-E / BP12C-E | Prompt usage                      | Prompt usage prompt  | Path references only                          |               |           |                |                  |
| H1      | WP-12C-E / BP12C-E | Prewrite allowed path             | PowerShell command   | PASS                                          |               |           |                |                  |
| H2      | WP-12C-E / BP12C-E | Prewrite sealed path              | PowerShell command   | Expected BLOCK                                |               |           |                |                  |
| H3      | WP-12C-E / BP12C-E | Postwrite validator               | PowerShell command   | PASS                                          |               |           |                |                  |
| H4      | WP-12C-E / BP12C-E | Session-stop summary              | PowerShell command   | Stdout only                                   |               |           |                |                  |
| H5      | WP-12C-E / BP12C-E | Precommit validator               | PowerShell command   | PASS                                          |               |           |                |                  |
| V1      | WP-12C-E / BP12C-E | Validator rerun                   | Section 12 commands  | 0 FAIL                                        |               |           |                |                  |
| G1      | WP-12C-E / BP12C-E | Git hygiene                       | Section 12 commands  | No staged files;`.claude/` not staged       |               |           |                |                  |
| F1      | WP-12C-D/E         | Founder acceptance                | Manual review        | Accepted evidence or documented gap           |               |           |                |                  |

## 12. Commit Readiness Checklist

Files safe to commit when validators are green and founder manual evidence is accepted:

- `tools/Test-AisrafPackage.ps1`
- `tools/Test-AisrafBp12AReadiness.ps1`
- `validation/package-12c-operator-experience-plan.md`
- `validation/package-12c-proposed-file-tree.md`
- `validation/package-12c-manual-operator-test-guide.md`
- `validation/agent-skill-projection-checklist.md`
- `validation/role-smoke-test-checklist.md`
- `validation/chat-preview-test-checklist.md`
- `validation/package-12c-controlled-output-checklist.md`
- `validation/package-12c-regression-checklist.md`
- `validation/package-12c-operator-card-usability-checklist.md`
- `.copilot-skills/`
- `.github/agents/`
- `tools/hooks/`

Files not safe to commit without explicit separate approval:

- Any file under `prompts/`
- Any file under `skills/`
- Any file under `prototype-agents/`
- Any file under `catalogs/`
- Any file under `blueprints/`
- Any file under `templates/`
- Any file under `samples/`
- Any file under `runs/RUN-001/`
- Any diagram or release artifact

Local-only files:

- `.claude/`

Optional provider projections:

- `.github/agents/` is commit-ready only if byte-identical to `.agents/` and validators pass.
- Future Microsoft Agent Framework, Azure AI Foundry, and Google ADK adapters are not implemented in WP-12C-E.

Validator commands:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

Git commands:

```powershell
git status --short
git diff --name-only
git diff --staged --name-only
git status --short -- .claude
```

Do not start WP-13 / BP13 until manual tests are accepted.

## 13. Export-Readiness Notes

[BLUE] The canonical guide remains Markdown for now.

[YELLOW] Word/PDF export is deferred until the release/documentation package permits binary reader artifacts.

[RED] Do not place DOCX, PDF, PPTX, or ZIP files in the repo until validators explicitly allow those artifacts.

[GREEN] Future export should use this Markdown guide as the source.

## 14. Final Gate Section

Use these statuses after testing:

- `WP-12C-D_MANUAL_TEST_PASS`: provider discovery and projection checks passed with evidence.
- `WP-12C-E_MANUAL_TEST_PASS`: role smoke, skill usage, prompt usage, hook usage, and chat-preview tests passed with evidence.
- `WP-12C-D/E_READY_FOR_COMMIT`: D/E artifacts are validated, manual evidence is accepted, `.claude/` is not staged, and no sealed surfaces changed.
- `WP-12C-D/E_PARTIAL_WITH_GAPS`: one or more manual tests failed or evidence is incomplete.
- `WP-13_READY_TO_START`: use only after founder accepts WP-12C-D/E evidence and explicitly opens WP-13.
- `WP-13_BLOCKED_PENDING_TEST_EVIDENCE`: default until manual D/E evidence is accepted.

Final closeout note: this guide is an operator test artifact. It is not a runtime adapter, not a prompt/skill replacement, not a diagram package, and not proof of external execution.

## 15. Workspace Guidance (Where To Run What — WP-12C-L2A-UX)

| Workspace | Purpose | Use For | Do Not Use For |
|---|---|---|---|
| `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE` | Installed-plugin operator testing. | Provider discovery, role preview prompts, hook smoke from the installed plugin, future controlled-output smoke after L2B authorization. | Editing canonical sources or validators. |
| `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` | Validation authoring and package development (the governed repo). | Authoring this guide and the related checklists, running validators, running `tools/Build-AisrafCopilotPluginBundle.ps1`, capturing package evidence. | Running installed-plugin smoke. Local `.agents/`, `.copilot-skills/`, `.github/agents/`, `.github/skills/`, `.github/hooks/` projections in this workspace will contaminate provider discovery and invalidate the evidence row. |

[RED] Do not run installed-plugin role smoke from the governed repo workspace. Re-run from the smoke workspace and recapture the row.

## 16. Terminal And Evidence Capture Guidance (WP-12C-L2A-UX)

| # | Requirement | Why |
|---|---|---|
| TERM-1 | Use a large terminal pane or the editor-area terminal. | Role preview output is multi-section; small panes interleave headings. |
| TERM-2 | Increase terminal scrollback before starting a smoke. | Role preview output exceeds default scrollback in some shells. |
| TERM-3 | Capture screenshots or copy / paste output after each role preview. | Evidence must be reviewable after the session ends. |
| TERM-4 | Run one role prompt at a time. | Concurrent prompts interleave provider output and break per-role attribution. |
| TERM-5 | Stop if output is interleaved beyond reviewability. | Continuing produces evidence that cannot be attributed to a specific role and fails L2 review. |
| TERM-6 | Record the workspace path in the evidence row. | The same role prompt is invalid evidence if captured from the governed repo workspace. |

[YELLOW] Finding Recommender (`@aisraf-finding-recommender`) was accepted at L2A with a UX caveat because output interleaved. Capture screenshots and accept if role identity and output shape are still attributable; otherwise stop and re-run.

## 17. UI / Provider Behaviour Notes (WP-12C-L2A-UX)

| Surface | Expected Behaviour | Why It Is Not A Failure |
|---|---|---|
| Copilot CLI plugin install report | May report success even when VS Code Local → Plugins shows no plugin. | Copilot CLI and VS Code Local read different provider registries; the CLI report is authoritative for L1A install evidence. |
| VS Code Agent Customizations panel | May show different agent / skill / hook counts vs. Copilot CLI. | Local and Copilot CLI providers discover different surfaces. Different counts are expected and are not drift unless a canonical surface is missing. |
| VS Code "Create Plugin" command | Must not be used for this governed package. | The plugin is a projection bundle authored by `tools/Build-AisrafCopilotPluginBundle.ps1`; "Create Plugin" would author plugin content outside the governed package. Use only the K3C build script. |

## 18. L2A-UX Final Status Pointer

Operator usability fixes for L2A live in
`validation/package-12c-plugin-install-and-publication-checklist.md`
§20 and the role-smoke runbook in
`validation/role-smoke-test-checklist.md` "L2A Role-Smoke Runbook".

L2B (controlled output) remains BLOCKED until L2A-UX is accepted and the
six L2B readiness items in install-checklist §20.5 are cleared.

## 19. Security Architect Operator Journey (WP-12C-L2B-UXA)

AISRAF is used as a local security architecture and design-review assistant.
The operator receives a review request, stages the local DFD/design package,
uses AISRAF roles to preview and then generate governed local outputs, and
keeps evidence under the approved run folder. The current product proof is the
VS Code Local provider in `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`; Copilot
CLI remains secondary and noisy.

### 19.1 Consumer Workspace Meaning

The smoke workspace may be empty. Empty is expected because plugin agents,
skills, and hooks are loaded from `aisraf-copilot-plugin` through
`chat.pluginLocations`, not from workspace-local customization folders. Do not
copy `.agents/`, `.github/agents/`, `.github/skills`, `.github/hooks`, or
`.copilot-skills` into the smoke workspace for product proof.

### 19.2 Local-Only Workflow

1. Receive the design review request.
2. Gather the local DFD/design package.
3. Stage inputs from `./samples/sample-001-dfd-crop/inputs/` or, for L2B after approval, `./runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/`.
4. Run preview-only role smoke.
5. Generate targeted pre-review questions.
6. Generate the review table.
7. Generate findings and recommendations.
8. Generate the handoff pack, validation notes, and score output only when scoring gates are met.
9. Keep all outputs local under `./runs/RUN-SMOKE-PLUGIN-L2B-001/`.

### 19.3 Future Adapter Workflow Boundary

The future adapter workflow may include Jira ticket intake, attached DFD or
Lucidchart export, design docs, transcript intake, targeted questions,
design-review support, updated DFD/transcript intake, final findings, final
recommendations, and Confluence/Jira post-back. In L2B these remain future-only:
Jira attachment read, Confluence page write, Lucidchart direct read, MCP
execution, cloud runtime, database, Terraform, Azure AI Foundry, Google ADK,
Microsoft Agent Framework, Claude runtime adapter, release, and external
post-back.

### 19.4 Input, Output, and Log Model

Inputs are local files such as DFD image/source, DFD legend, intake ticket text,
cloud triage notes, review transcript, and supporting notes. L2B outputs are
only the 18 root RS files and 9 DFD subchain files listed in the L2B plan and
in the install checklist Section 22.6.

`00-run-log.md` must record run identity, mode, input root, output root, roles
invoked, files read, files written, guard results, focused validator results,
stop conditions, external execution status, and the final PASS / PARTIAL /
FAIL summary.

### 19.5 DFD Review Annotation Requirements

Every DFD-derived output should carry visible evidence for data
classification, source, destination, trust or boundary crossing,
authentication signal, authorization signal, encryption in transit,
encryption at rest for stores, and logging / monitoring / control evidence.
Unknown values must be carried forward as `unknown`; do not invent facts to
make a row look complete.

### 19.6 Evidence Capture

Accept copied terminal output, screenshots, saved transcript text, validator
transcript, and Git hygiene transcript. Recommended terminal setting:

```json
"terminal.integrated.scrollback": 50000
```

Use the terminal in the editor area, run one role at a time, do not run
parallel role prompts, and stop if output becomes unattributable.
