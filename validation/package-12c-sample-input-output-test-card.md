# Build Package 12C — Sample Input / Output Test Card

| Field | Value |
|---|---|
| Card name | AISRAF Sample Input / Output Test Card |
| Work package | WP-12C-H — Copilot Skill Format Repair + Chat/CLI Test Harness |
| Status | Manual evidence pending |
| Audience | Founder, local operator, reviewer |
| Purpose | Prove each AISRAF role can use sample-001 / RUN-001 as read-only context (Test 4) and can show its expected output shape (Test 5) without writing files |
| Companion cards | `validation/package-12c-quick-manual-test-card.md`, `validation/package-12c-manual-operator-test-guide.md` |
| Mode | MODE A — Chat Preview Mode only. Mode B (controlled file output) is DEFERRED until founder approval. |

## Read Before Starting

- This card is preview-only. Every test must end with `git status --short` reporting no change.
- Read-only context for every test:
  - `samples/sample-001-dfd-crop/inputs/`
  - `samples/sample-001-dfd-crop/expected/`
  - `runs/RUN-001/inputs/`
  - `runs/RUN-001/run-profile.yaml`
  - the provider skill package at `.github/skills/<skill-id>/SKILL.md`
  - the local wrapper and operator card under `.copilot-skills/`
  - the role adapter and canonical PRA/prompt/skill references
- Sealed surfaces (do not edit during this card): `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/`.
- Local-only: `.claude/`. Never staged.
- Do not write a file in this card. Mode B file writes are governed by `validation/package-12c-controlled-output-checklist.md` and the prewrite hook.

## Standard Loop For Every Row

1. Open VS Code in `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`.
2. Open Copilot Chat / Agent Mode.
3. Select the AISRAF agent named in the row.
4. Paste the prompt from the row.
5. Compare the answer to the expected response shape and PASS criteria.
6. Run `git status --short`.
7. Mark PASS or FAIL in the evidence sheet.
8. Move to the next row.

## Section A — Test 4, Sample Input Preview

Goal: each agent confirms which input files it would read for a sample-001 / RUN-001 run, and explicitly says it writes nothing in preview.

### Common Prompt Pattern

Replace `<role>` and `<wrapper-id>` per row.

```text
SAMPLE INPUT PREVIEW TEST — WP-12C-H. Selected role: <role>. Skill: <wrapper-id>. Preview only. Write nothing. Do not modify RUN-001. Read-only context: .github/skills/<wrapper-id>/SKILL.md, .copilot-skills/<wrapper-id>.skill.md, samples/sample-001-dfd-crop/inputs, samples/sample-001-dfd-crop/expected, runs/RUN-001/inputs, runs/RUN-001/run-profile.yaml. Return exactly these headings: Inputs read; Inputs ignored; Why these inputs; Expected unknowns; Files written; Stop conditions for input reading.
```

### Per-Role Rows

| Row | Role | Wrapper | PASS — Inputs Read Names At Least | PASS — Files Written |
|---|---|---|---|---|
| A1 | AISRAF Orchestrator | `aisraf-orchestration` | `runs/RUN-001/run-profile.yaml`, downstream output paths under `runs/{{run_id}}/` (read-only) | `none in preview` |
| A2 | AISRAF Input Reader | `aisraf-input-read` | `runs/RUN-001/inputs/dfd-crop.png`, `dfd-crop.mmd`, `architecture-and-data.md`, `data-stores.md`, `interview-transcript.md`, `assumed-controls-and-evidence.md` | `none in preview` |
| A3 | AISRAF DFD Extractor | `aisraf-dfd-extraction` | `runs/RUN-001/inputs/dfd-crop.png`, `dfd-crop.mmd` (and the supporting notes for legend hints) | `none in preview` |
| A4 | AISRAF Review Table Builder | `aisraf-review-table-build` | the three DFD outputs under `runs/RUN-001/dfd/` and the four extracted RS outputs `02..05` under `runs/RUN-001/` (read-only) | `none in preview` |
| A5 | AISRAF Blueprint Questioner | `aisraf-blueprint-questioning` | `runs/RUN-001/06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md`, plus `catalogs/` and `blueprints/` references by path | `none in preview` |
| A6 | AISRAF Finding Recommender | `aisraf-finding-recommendation` | `runs/RUN-001/09..12` outputs, plus the upstream review table and blueprint match files | `none in preview` |
| A7 | AISRAF Handoff QA Scorer | `aisraf-handoff-qa-score` | `runs/RUN-001/13-findings.md`, `14-recommendations.md`, plus the full upstream chain output set | `none in preview` |

PASS criteria for Section A:

- Response names the listed input paths.
- Response says `none in preview` for files written.
- Response carries unknowns explicitly (`IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, `match=unknown` where applicable).
- `git status --short` shows no change after the row.

FAIL criteria:

- Response invents an input path that does not exist.
- Response claims any file write in preview.
- Response fills `unknown` with a guess.
- Any sealed surface changes during the row.

## Section B — Test 5, Sample Output Shape

Goal: each agent shows the shape of the output it would produce for sample-001 / RUN-001, by reference to the canonical template, without copying the template body.

### Common Prompt Pattern

Replace `<role>`, `<wrapper-id>`, and `<output template paths>` per row.

```text
SAMPLE OUTPUT SHAPE TEST — WP-12C-H. Selected role: <role>. Skill: <wrapper-id>. Preview only. Write nothing. Do not modify RUN-001. Reference provider skill package .github/skills/<wrapper-id>/SKILL.md and templates by path only: <output template paths>. Render the section headings of the expected output, leave each section body as a one-line shape hint, and end with "Files written: none in preview". Do not copy the canonical template body. Do not invent new sections.
```

### Per-Role Rows

| Row | Role | Wrapper | Canonical Template(s) Referenced | Approved Output File(s) Under `runs/{{run_id}}/` |
|---|---|---|---|---|
| B1 | AISRAF Orchestrator | `aisraf-orchestration` | `templates/output/output-00-run-log-template.md` | `00-run-log.md` |
| B2 | AISRAF Input Reader | `aisraf-input-read` | `templates/output/output-01-input-inventory-template.md` | `01-input-inventory.md` |
| B3 | AISRAF DFD Extractor | `aisraf-dfd-extraction` | `templates/output/output-02-visible-dfd-objects-template.md` through `output-05-flows-template.md`; the 9 DFD output templates | `02-visible-dfd-objects.md`, `03-legend-normalization.md`, `04-components.md`, `05-flows.md`, `dfd/01..09-*.md` |
| B4 | AISRAF Review Table Builder | `aisraf-review-table-build` | `output-06-boundaries-template.md`, `output-07-security-stack-assessment-template.md`, `output-08-internal-review-table-template.md` | `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` |
| B5 | AISRAF Blueprint Questioner | `aisraf-blueprint-questioning` | `output-09-missing-facts-template.md` through `output-12-targeted-questions-template.md` | `09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md` |
| B6 | AISRAF Finding Recommender | `aisraf-finding-recommendation` | `output-13-findings-template.md`, `output-14-recommendations-template.md` | `13-findings.md`, `14-recommendations.md` |
| B7 | AISRAF Handoff QA Scorer | `aisraf-handoff-qa-score` | `output-15-handoff-pack-template.md` through `output-17-accuracy-score-template.md` | `15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` |

PASS criteria for Section B:

- Response renders only the canonical section headings, with one-line shape hints per section.
- Response references the canonical template paths, no template body is copied.
- Response ends with `Files written: none in preview`.
- For B7 specifically, response describes scoring conditions before claiming any score band; if conditions are not met, response carries `match=unknown` or `score=unknown` instead of a number.
- `git status --short` shows no change after the row.

FAIL criteria:

- Response copies a multi-line block from a canonical template body.
- Response invents a section heading that is not in the canonical template.
- Response claims a runtime / cloud / Microsoft Agent Framework / Azure AI Foundry / Google ADK / MCP / Jira / Confluence / Rovo / database / Terraform / release execution.
- Response claims a numeric accuracy score in B7 without naming the scoring conditions.
- Any sealed surface changes during the row.

## Section C — Combined PASS / FAIL Pattern

| Row Group | Combined PASS Means | Combined FAIL Means |
|---|---|---|
| A1 + B1 | Orchestrator names the run profile as input and the run-log template shape as output, writes nothing | Either inventing inputs or claiming a write |
| A2 + B2 | Input Reader names the 6 sample input files and the input inventory template shape, writes nothing | Inventing files, claiming chat-attachment movement, or claiming a write |
| A3 + B3 | DFD Extractor names the DFD PNG/MMD pair (and supporting notes) and renders the 4 RS DFD output shapes plus 9 DFD subskill output shapes by reference, writes nothing | Generating diagrams, inventing facts, copying template bodies |
| A4 + B4 | Review Table Builder names the upstream extracted outputs and renders the boundaries / stack / review-table shapes by reference, writes nothing | Asserting controls without evidence, skipping a declared output |
| A5 + B5 | Blueprint Questioner names the upstream review-table outputs and renders missing-facts / AAL / blueprint-match / targeted-questions shapes, writes nothing | Inventing answers, broad-checklist questions, or claiming AAL without classification logic |
| A6 + B6 | Finding Recommender names parent findings as the source for recommendations and renders findings / recommendations shapes, writes nothing | Recommendations without parent findings, invented owner/control evidence |
| A7 + B7 | Handoff QA Scorer names the full upstream chain and renders handoff / validation-notes / accuracy-score shapes, scoring claim conditional on declared scoring conditions, writes nothing | Inflated score, baselines edited, scoring without conditions, external publication claim |

## Section D — Stop Conditions For This Card

- Any sealed surface changes during a row.
- Any response claims a runtime / cloud / MCP / ADK / Microsoft Agent Framework / Azure AI Foundry / Google ADK / Jira / Confluence / Rovo / database / Terraform / release execution.
- Any response copies the body of a canonical template, prompt, or skill instead of referencing the path.
- Any response claims a file was written during a preview row.
- Validators regress (run Section F of `validation/package-12c-quick-manual-test-card.md` to confirm).

## Section E — Bring-Your-Own-DFD Note

This card uses sample-001 / RUN-001 only.

To preview a different DFD with the same shape of test:

1. Create `runs/RUN-SMOKE-LOCAL-XXX/` with a valid run id.
2. Copy your DFD PNG/MMD and any supporting notes into `runs/RUN-SMOKE-LOCAL-XXX/inputs/`.
3. Author or generate `runs/RUN-SMOKE-LOCAL-XXX/run-profile.yaml` matching `config/run-profile.schema.yaml`.
4. Re-run Sections A and B against `runs/RUN-SMOKE-LOCAL-XXX/` instead of `runs/RUN-001/` (paths above are illustrative only — the canonical references stay the same).
5. Confirm `runs/RUN-001/` is byte-stable.
6. Do not enter Mode B without explicit founder approval and the controlled-output checklist.

## Section F — Evidence Worksheet

| Row | Test | Role / Wrapper | Result | Notes |
|---|---|---|---|---|
| A1 | Sample input preview | AISRAF Orchestrator / `aisraf-orchestration` | | |
| A2 | Sample input preview | AISRAF Input Reader / `aisraf-input-read` | | |
| A3 | Sample input preview | AISRAF DFD Extractor / `aisraf-dfd-extraction` | | |
| A4 | Sample input preview | AISRAF Review Table Builder / `aisraf-review-table-build` | | |
| A5 | Sample input preview | AISRAF Blueprint Questioner / `aisraf-blueprint-questioning` | | |
| A6 | Sample input preview | AISRAF Finding Recommender / `aisraf-finding-recommendation` | | |
| A7 | Sample input preview | AISRAF Handoff QA Scorer / `aisraf-handoff-qa-score` | | |
| B1 | Sample output shape | AISRAF Orchestrator / `aisraf-orchestration` | | |
| B2 | Sample output shape | AISRAF Input Reader / `aisraf-input-read` | | |
| B3 | Sample output shape | AISRAF DFD Extractor / `aisraf-dfd-extraction` | | |
| B4 | Sample output shape | AISRAF Review Table Builder / `aisraf-review-table-build` | | |
| B5 | Sample output shape | AISRAF Blueprint Questioner / `aisraf-blueprint-questioning` | | |
| B6 | Sample output shape | AISRAF Finding Recommender / `aisraf-finding-recommendation` | | |
| B7 | Sample output shape | AISRAF Handoff QA Scorer / `aisraf-handoff-qa-score` | | |
| C | Combined PASS/FAIL summary | | | |

## Final Gate

- `WP-12C-G_SAMPLE_IO_PASS` — every row PASS; no FAIL.
- `WP-12C-G_SAMPLE_IO_PARTIAL` — at least one row PASS plus one or more FAIL or skipped row; record details.
- `WP-12C-G_SAMPLE_IO_FAIL` — any FAIL row; stop and record the role, transcript, and `git status --short`.

Mode B (controlled file output) is governed by `validation/package-12c-controlled-output-checklist.md` and is not authorized by this card.
