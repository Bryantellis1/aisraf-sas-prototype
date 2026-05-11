# Build Package 12C — Quick Manual Test Card

| Field | Value |
|---|---|
| Card name | AISRAF Quick Manual Test Card |
| Work package | WP-12C-H — Copilot Skill Format Repair + Chat/CLI Test Harness |
| Status | Manual evidence pending |
| Audience | Founder, local operator |
| Purpose | Walk one operator through Copilot Chat, Copilot CLI, hooks, sample preview, validators, and git hygiene without reading the long playbook |
| Long-form companion | `validation/package-12c-manual-operator-test-guide.md` |
| Sample input/output companion | `validation/package-12c-sample-input-output-test-card.md` |
| Last validator state | Test-AisrafPackage 79 PASS, 0 WARN, 0 FAIL; Test-AisrafBp12AReadiness 77 PASS, 0 FAIL; Test-AisrafRunProfile -ExecutionReady 12 PASS, 0 FAIL |

## Read Before Starting

- AISRAF is a local security architecture and design-review assistant for DFD/design packages.
- Current AISRAF plugin proof supports local preview and explicitly approved local controlled-output generation only.
- It does not currently execute Jira, Confluence, Lucidchart, MCP, cloud runtime, database, Terraform, release, or external post-back actions.
- This card is preview-only. No file should change because of any test on this card.
- Sealed surfaces: `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/`. Stop on any change.
- Local-only: `.claude/`. Do not stage. Do not use `git add .`.
- `.github/skills/<skill-id>/SKILL.md` is the provider-discoverable AISRAF Agent Skills projection.
- `.copilot-skills/` remains the local/operator wrapper projection and is retained for reference; it is not the provider skill package format.
- `.github/hooks/*.json` is the provider-supported hook configuration surface. `tools/hooks/` remains the reusable PowerShell hook implementation.
- `.github/prompts/` is not required for this card; the test prompts live here to avoid extra provider surface.

## Workspace Guidance (WP-12C-L2A-UX)

- Run **installed-plugin** smoke from `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE` (the isolated smoke workspace).
- The smoke workspace may be empty. Empty is expected and proves the plugin is loading from the plugin source/cache instead of workspace-local customization folders.
- Do not copy `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, or `.copilot-skills/` into the smoke workspace for product proof.
- Use `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` (the governed repo) only for validation authoring and package development.
- Do not run installed-plugin role smoke from the governed repo workspace; local projection folders (`.agents/`, `.copilot-skills/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`) contaminate discovery.
- Do not use VS Code "Create Plugin" for this governed package. The plugin is a projection bundle authored by `tools/Build-AisrafCopilotPluginBundle.ps1`.
- Copilot CLI install reporting and VS Code Local → Plugins counts can disagree; they read different provider registries and the divergence is not a failure on its own.

## Plugin, User, Workspace, And Built-In Sources

| Source | Meaning | Product Proof Rule |
|---|---|---|
| Plugin | Shipped by `aisraf-copilot-plugin`; use for AISRAF product proof. | PASS source when AISRAF plugin agents are visible. |
| User | Personal/global customizations. | Not product proof. |
| Workspace | Local repo/project customizations. | Not installed-plugin proof. |
| Built-in | Default Copilot / VS Code agents. | Expected background rows. |
| eWay | Main-profile personal agents. | User-profile noise if seen outside the Local proof surface. |

Duplicate-looking AISRAF rows are acceptable only when their source is separated and the plugin-provided AISRAF agents remain visible. eWay agents should be absent from the clean Local provider proof surface.

## Terminal And Evidence Capture (WP-12C-L2A-UX)

- Use a large terminal pane or the editor-area terminal.
- Increase scrollback before starting smoke.
- Capture screenshots or paste output after each role preview.
- Run one role prompt at a time.
- Stop if output interleaves beyond reviewability.
- Record the workspace path in the evidence row.

## Standard Loop For Every Test

1. For installed-plugin proof, open VS Code in `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`.
2. Use `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` only for validators, hook commands, and Git hygiene.
3. Open Copilot Chat / Agent Mode (or open Copilot CLI for the CLI rows).
4. Select the AISRAF agent named in the row.
5. Paste the prompt from the row.
6. Check the response against the headings or PASS pattern.
7. Run `git status --short` from the governed repo when the row requires Git evidence.
8. Mark PASS or FAIL in the evidence sheet at the end.
9. Move to the next test.

## Test Type Map

| Test | Purpose | Surface | Writes Files? |
|---|---|---|---|
| TEST 1 — Discovery | Can the provider see agents, skills, prompts, and hooks? | VS Code, Copilot Chat, Copilot CLI, filesystem | No |
| TEST 2 — Agent Smoke | Does each agent know who it is and what it must not do? | VS Code Chat first; CLI where supported | No |
| TEST 3 — Skill Wiring | Does each provider skill map back to canonical PRA/prompt/skill paths? | Copilot Chat; Copilot CLI where supported | No |
| TEST 4 — Sample Input Preview | Can the agent use sample-001 / RUN-001 as read-only context? | VS Code Chat first | No (see sample input/output card) |
| TEST 5 — Sample Output Shape | Can the agent show what output it would produce? | VS Code Chat first | No (see sample input/output card) |
| TEST 6 — Hook | Do hooks protect the repo? | PowerShell | No |
| TEST 7 — Validator | Does the package stay structurally clean? | PowerShell | No |
| TEST 8 — Git Hygiene | No drift, no staged `.claude/`, no sealed edits | Git | No |
| TEST 9 — Controlled File Output | Real files written safely under scratch run | Scratch run only | YES — DEFERRED until founder approval |

## Section A — Test 1, Discovery

### A.1 — VS Code Local Discovery

| Step | Check | PASS Looks Like |
|---|---|---|
| 1 | Open Local customization view | Lists 7 AISRAF agents under Local |
| 2 | Look for AISRAF skills under Local | Lists 7 AISRAF skills from `.github/skills/<skill-id>/SKILL.md` |
| 3 | Look for AISRAF hooks under Local or hook diagnostics | Shows `.github/hooks/aisraf-guardrails.json` loaded, or diagnostics explain why hooks are disabled |
| 4 | Open `.github/copilot-instructions.md` | File present and readable |
| 5 | Open `.github/skills/aisraf-input-read/SKILL.md` | File present; frontmatter name matches parent folder |
| 6 | Open `.copilot-skills/README.md` | File present; lists 7 retained local/operator wrappers |
| 7 | Open `tools/hooks/README.md` | File present; lists 4 hook scripts |

### A.2 — VS Code Copilot Chat Discovery

| Step | Check | PASS Looks Like |
|---|---|---|
| 1 | Open Agent dropdown in Copilot Chat | 7 AISRAF agents visible by display name |
| 2 | Read instructions area | `.github/copilot-instructions.md` content reflected |
| 3 | Type `/` and look for AISRAF skill slash commands | 7 AISRAF skills visible by skill id |
| 4 | Open hook diagnostics / Hooks output channel | `.github/hooks/aisraf-guardrails.json` is loaded or reports an actionable config/policy error |

### A.3 — Copilot CLI Discovery

| Step | Check | PASS Looks Like |
|---|---|---|
| 1 | Open Copilot CLI in repo root | CLI session starts from the AISRAF repo root |
| 2 | Confirm the CLI can see workspace custom agents | If the local CLI UI/settings support workspace custom agents, 7 AISRAF agents are visible |
| 3 | Confirm whether CLI can see AISRAF skills | `/` menu or equivalent provider surface lists 7 AISRAF skills beyond built-ins |
| 4 | Confirm whether CLI can see hooks | Provider hook diagnostics or CLI session behavior indicates `.github/hooks/aisraf-guardrails.json` is loaded |

Do not invent CLI flags or commands. If the exact Copilot CLI command is not confirmed in local/provider docs, write `CLI command pending provider confirmation` in the evidence row.

## Section B — Test 2, Agent Smoke (VS Code Chat)

For each agent, paste the prompt below verbatim. Replace the agent name. Headings expected: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.

```text
ROLE SMOKE TEST. Selected role: <AISRAF role name>. Preview only. Write nothing. Do not modify RUN-001. Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, Microsoft Agent Framework, Azure AI Foundry, Google ADK, database, Terraform, release, or post-back execution. Read only the role adapter, the operator card, and runs/RUN-001/run-profile.yaml. Return exactly these headings: Role identity; Reads; Writes; Stop conditions; Expected output; Prohibited claims.
```

| Row | Agent | PASS Names PRA | PASS Declared Writes (under `runs/{{run_id}}/`) |
|---|---|---|---|
| B1 | AISRAF Orchestrator | PRA-01 | `00-run-log.md` |
| B2 | AISRAF Input Reader | PRA-02 | `01-input-inventory.md` |
| B3 | AISRAF DFD Extractor | PRA-03, PRA-04 | `02..05` and `dfd/01..09` |
| B4 | AISRAF Review Table Builder | PRA-05 | `06`, `07`, `08` |
| B5 | AISRAF Blueprint Questioner | PRA-06 | `09`, `10`, `11`, `12` |
| B6 | AISRAF Finding Recommender | PRA-07 | `13`, `14` |
| B7 | AISRAF Handoff QA Scorer | PRA-08 | `15`, `16`, `17` |

After each agent: `git status --short`. Expect no change.

## Section C — Test 3, Skill Wiring (VS Code Chat)

For each row, select the agent, then paste:

```text
SKILL WIRING TEST. Skill ID: <wrapper-id>. Selected agent: <agent-name>. Preview only. Write nothing. State the provider skill package at .github/skills/<wrapper-id>/SKILL.md, the local wrapper file you reference, the canonical PRA file path, the canonical prompt path(s), the canonical skill path(s), the allowed run output paths, and the chat-preview / controlled-output behavior. Reference paths only. Do not copy prompt or skill bodies. Do not invent paths.
```

| Row | Skill ID | Agent | PASS If Response Names |
|---|---|---|---|
| C1 | `aisraf-orchestration` | AISRAF Orchestrator | PRA-01, `prompts/rs/00-run-full-chain.prompt.md`, owns no skill |
| C2 | `aisraf-input-read` | AISRAF Input Reader | PRA-02, `prompts/rs/01-input-package-read.prompt.md`, `skills/rs/SK-INPUT-PACKAGE-READ.md` |
| C3 | `aisraf-dfd-extraction` | AISRAF DFD Extractor | PRA-03 + PRA-04, RS DFD prompts, DFD prompt chain, RS/DFD skills |
| C4 | `aisraf-review-table-build` | AISRAF Review Table Builder | PRA-05, `prompts/rs/05-..` and `06-..`, three RS skills |
| C5 | `aisraf-blueprint-questioning` | AISRAF Blueprint Questioner | PRA-06, prompts `07..09`, four RS skills |
| C6 | `aisraf-finding-recommendation` | AISRAF Finding Recommender | PRA-07, `prompts/rs/10-..`, two RS skills |
| C7 | `aisraf-handoff-qa-score` | AISRAF Handoff QA Scorer | PRA-08, prompts `11..13`, three RS skills |

After each row: `git status --short`. Expect no change.

## Section D — Test 4 + 5, Sample Input / Output Preview

Use the dedicated card: `validation/package-12c-sample-input-output-test-card.md`.

That card carries one prompt per role for sample input preview and one prompt per role for sample output shape, plus PASS criteria and evidence rows. Do not duplicate that work here.

## Section E — Test 6, Hooks (PowerShell)

Run from repo root.

| Row | Command | PASS Looks Like |
|---|---|---|
| E0 (provider config) | Open `.github/hooks/aisraf-guardrails.json` | File exists; uses `PreToolUse`, `PostToolUse`, and `Stop`; references scripts under `tools/hooks/` |
| E1 (allowed scratch) | `pwsh -NoProfile -File ./tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath runs/RUN-SMOKE-LOCAL-001/01-input-inventory.md` | `PASS aisraf-allowed-path-prewrite-guard target=runs/RUN-SMOKE-LOCAL-001/01-input-inventory.md` |
| E2 (sealed prompt) | `pwsh -NoProfile -File ./tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath prompts/rs/01-input-package-read.prompt.md` | `FAIL aisraf-allowed-path-prewrite-guard target=prompts/rs/01-input-package-read.prompt.md reason=not_on_allow_list` and exit 1. The block is the good outcome. |
| E3 (postwrite validator) | `pwsh -NoProfile -File ./tools/hooks/aisraf-focused-validator-postwrite.ps1 -TargetPath runs/RUN-SMOKE-LOCAL-001/01-input-inventory.md` | Package validator returns `0 FAIL`, then `PASS aisraf-focused-validator-postwrite` |
| E4 (session summary, stdout only) | `pwsh -NoProfile -File ./tools/hooks/aisraf-session-stop-summary.ps1 -WrapperId aisraf-input-read -InputsRead runs/RUN-001/inputs -OutputsWritten none -ValidatorsInvoked tools/Test-AisrafPackage.ps1 -Status PREVIEW_ONLY` | Stdout begins `SUMMARY aisraf-session-stop-summary` and `git status --short` shows no new change |
| E5 (precommit full validator) | `pwsh -NoProfile -File ./tools/hooks/aisraf-precommit-full-validator.ps1` | `Test-AisrafBp12AReadiness` returns `0 FAIL`, then `PASS aisraf-precommit-full-validator` |

Stop conditions: any unexpected PASS for E2; any FAIL for E1, E3, E4, or E5.

## Section F — Test 7, Validators (PowerShell)

Run from repo root.

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

PASS thresholds: 0 FAIL on each. Any FAIL stops the card.

## Section G — Test 8, Git Hygiene

```powershell
git status --short
git diff --name-only
git diff --staged --name-only
git status --short -- .claude
```

PASS criteria:

- Only the BP12C planning, BP12C-Implementation, and BP12C-G planning files appear in modified or untracked.
- `.claude/` listed only as untracked. Never staged.
- No file under `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, or `runs/RUN-001/` shows as modified.

## Section H — Test 9, Controlled File Output (Deferred)

Status: **DEFERRED**. Do not run without explicit founder approval. Plan, run-profile posture, and hook routes live in §10 of `validation/package-12c-manual-operator-test-guide.md`.

Approved L2B scratch root: `runs/RUN-SMOKE-PLUGIN-L2B-001/...`. Never write to `runs/RUN-001/`. Never write to `samples/`.

Input staging after explicit approval: `runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/` copied from `samples/sample-001-dfd-crop/inputs/`.

Output writes after explicit approval: only the canonical root RS outputs `00-run-log.md` through `17-accuracy-score.md` and DFD outputs `dfd/01-intake-quality-check.md` through `dfd/09-extraction-summary.md`.

Guard before each write:

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath <target-file>
```

Focused validator after each write:

```powershell
pwsh -NoProfile -File ./tools/hooks/aisraf-focused-validator-postwrite.ps1 -TargetPath <target-file>
```

## Section I — Copilot CLI Test (Separate From VS Code Chat)

Treat Copilot CLI as a different surface from VS Code Chat. Different discovery rules apply.

| Row | What To Try In Copilot CLI | Expected | Action If Provider Limit |
|---|---|---|---|
| I1 | Open Copilot CLI in repo root and confirm workspace custom agents | If CLI custom agents are enabled, 7 AISRAF agents listed. | If syntax is not documented locally, write `CLI command pending provider confirmation`. |
| I2 | Confirm CLI can see AISRAF skills | 7 AISRAF skills from `.github/skills/<id>/SKILL.md` visible beyond built-ins. | If only built-ins appear, capture diagnostics and mark FAIL unless provider docs/policy explain a limitation. |
| I3 | Invoke one AISRAF agent if command syntax is known and ask Section B smoke prompt | Same headings as Section B. | If CLI cannot select agents by name, record PROVIDER LIMITATION. Do not invent syntax. |
| I4 | Ask the skill wiring prompt from Section C | Same answer shape as Section C. | If CLI cannot route to provider skills, record PROVIDER LIMITATION with evidence. |
| I5 | Run `git status --short` after the CLI session | No file changes. | If files changed, FAIL. Stop and inspect. |

Do not invent CLI flags or commands. If you cannot confirm a CLI command from current provider docs, write `CLI command pending provider confirmation`.

## Bring-Your-Own-DFD (Future Operator Scenario, Not Implemented Today)

When you want to test a DFD that is not sample-001:

1. Create a new approved scratch run folder named `runs/RUN-SMOKE-LOCAL-XXX/` (run id must match `RUN-[A-Z0-9][A-Z0-9-]*`).
2. Place the DFD PNG, MMD, transcript, and supporting notes in `runs/RUN-SMOKE-LOCAL-XXX/inputs/`.
3. Author or generate `runs/RUN-SMOKE-LOCAL-XXX/run-profile.yaml` matching `config/run-profile.schema.yaml`.
4. Run preview tests from Sections B, C, D first. Write nothing.
5. Only after every preview row passes, request founder approval to enter Mode B.
6. In Mode B, outputs land only under the new scratch `output_root`. The prewrite guard enforces the allow-list pattern.
7. Run validators after every output.
8. Confirm `runs/RUN-001/` is byte-stable before, during, and after the scratch run.

Never overwrite `runs/RUN-001/`. Never edit sealed baselines directly. Never accept uncontrolled writes.

## Evidence Worksheet

| Row | Test | Surface | Result | Notes |
|---|---|---|---|---|
| A.1 | Local discovery | VS Code | | |
| A.2 | Chat discovery | Copilot Chat | | |
| A.3 | CLI discovery | Copilot CLI | | |
| B1–B7 | Agent smoke (per role) | Copilot Chat | | |
| C1–C7 | Skill wiring (per wrapper) | Copilot Chat | | |
| D | Sample input / output preview | See sample input/output card | | |
| E0–E5 | Hooks | PowerShell and provider hook config | | |
| F | Validators | PowerShell | | |
| G | Git hygiene | Git | | |
| H | Controlled file output | DEFERRED | DEFERRED | Do not run without approval |
| I1–I5 | Copilot CLI | Copilot CLI | | |

## Final Gate

- `WP-12C-H_QUICK_CARD_PASS` — every applicable row PASS or PROVIDER LIMITATION; no FAIL.
- `WP-12C-H_QUICK_CARD_PARTIAL` — at least one PASS plus one or more PROVIDER LIMITATION; no FAIL.
- `WP-12C-H_QUICK_CARD_FAIL` — any FAIL row; stop and record.

PROVIDER LIMITATION is not a defect of AISRAF. Mark, capture, and continue.

## L2A / L2A-UX / L2B Pointers

- L2A installed-plugin role-smoke runbook: `validation/role-smoke-test-checklist.md` "L2A Role-Smoke Runbook".
- L2A-UX operator usability patch: `validation/package-12c-plugin-install-and-publication-checklist.md` §20.
- L2B security architect journey and consumer workspace addendum: `validation/package-12c-plugin-install-and-publication-checklist.md` Section 22.
- L2B controlled-output readiness gates (execution currently BLOCKED): install-checklist Section 22.9.
- Future integrations (Jira, Confluence, Lucidchart, MCP, Claude, Foundry, ADK, MAF, DB, Terraform, post-back) are governed adapter paths only; not active in L2A or L2B.
- L3 is the first gate that may decide staging or publication; do not stage `.claude/`, smoke folders, or run `git add .` before L3 acceptance.
