# Build Package 04 — Prompts And Prompt Registry Checklist

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 04.
Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml)
Validation authority: [config/run-profile.validation-rules.md](../config/run-profile.validation-rules.md)
Prompt registry authority: [prompts/prompt-registry.yaml](../prompts/prompt-registry.yaml)
No-drift authority: [validation/no-drift-rules.md](no-drift-rules.md)

This checklist is the acceptance gate for Build Package 04. Every required item must read PASS before Build Package 05 (Skills and skill registry) may begin. FAIL items must be resolved or recorded as explicit blockers.

## 1. Prompt-file presence

| # | Check | Status | Evidence |
|---|---|---|---|
| 1.1 | [prompts/README.md](../prompts/README.md) updated for Build Package 04 | PASS | active-package description, registry pointer, parameter contract, and forbidden claims listed |
| 1.2 | [prompts/prompt-registry.yaml](../prompts/prompt-registry.yaml) exists | PASS | this file present |
| 1.3 | [prompts/rs/README.md](../prompts/rs/README.md) exists | PASS | RS family overview present |
| 1.4 | [prompts/dfd/README.md](../prompts/dfd/README.md) exists | PASS | DFD family overview present |
| 1.5 | RS prompt cards exist (14) | PASS | see Section 2 inventory |
| 1.6 | DFD prompt cards exist (9) | PASS | see Section 3 inventory |
| 1.7 | [validation/package-04-prompts-checklist.md](package-04-prompts-checklist.md) exists | PASS | this file |
| 1.8 | [validation/prompt-registry-checklist.md](prompt-registry-checklist.md) exists | PASS | sibling checklist for registry-only checks |

## 2. RS prompt inventory (14 files)

| # | File | Prompt ID | Status | Status |
|---|---|---|---|---|
| 2.1 | [prompts/rs/00-run-full-chain.prompt.md](../prompts/rs/00-run-full-chain.prompt.md) | PR-RS-00 | planned | PASS |
| 2.2 | [prompts/rs/01-input-package-read.prompt.md](../prompts/rs/01-input-package-read.prompt.md) | PR-RS-01 | active | PASS |
| 2.3 | [prompts/rs/02-dfd-visual-read.prompt.md](../prompts/rs/02-dfd-visual-read.prompt.md) | PR-RS-02 | active | PASS |
| 2.4 | [prompts/rs/03-legend-normalization.prompt.md](../prompts/rs/03-legend-normalization.prompt.md) | PR-RS-03 | active | PASS |
| 2.5 | [prompts/rs/04-design-fact-extract.prompt.md](../prompts/rs/04-design-fact-extract.prompt.md) | PR-RS-04 | active | PASS |
| 2.6 | [prompts/rs/05-boundary-stack-detect.prompt.md](../prompts/rs/05-boundary-stack-detect.prompt.md) | PR-RS-05 | active | PASS |
| 2.7 | [prompts/rs/06-review-table-build.prompt.md](../prompts/rs/06-review-table-build.prompt.md) | PR-RS-06 | active | PASS |
| 2.8 | [prompts/rs/07-missing-fact-question-generate.prompt.md](../prompts/rs/07-missing-fact-question-generate.prompt.md) | PR-RS-07 | active | PASS |
| 2.9 | [prompts/rs/08-ai-action-level-classify.prompt.md](../prompts/rs/08-ai-action-level-classify.prompt.md) | PR-RS-08 | active | PASS |
| 2.10 | [prompts/rs/09-blueprint-match.prompt.md](../prompts/rs/09-blueprint-match.prompt.md) | PR-RS-09 | active | PASS |
| 2.11 | [prompts/rs/10-finding-recommendation-write.prompt.md](../prompts/rs/10-finding-recommendation-write.prompt.md) | PR-RS-10 | active | PASS |
| 2.12 | [prompts/rs/11-handoff-pack-build.prompt.md](../prompts/rs/11-handoff-pack-build.prompt.md) | PR-RS-11 | active | PASS |
| 2.13 | [prompts/rs/12-validation-note-write.prompt.md](../prompts/rs/12-validation-note-write.prompt.md) | PR-RS-12 | active | PASS |
| 2.14 | [prompts/rs/13-accuracy-score.prompt.md](../prompts/rs/13-accuracy-score.prompt.md) | PR-RS-13 | active (conditional) | PASS |
| 2.15 | RS prompt count = 14 | PASS | inventory above |

## 3. DFD prompt inventory (9 files)

| # | File | Prompt ID | Status | Status |
|---|---|---|---|---|
| 3.1 | [prompts/dfd/02-dfd-intake-quality-check.prompt.md](../prompts/dfd/02-dfd-intake-quality-check.prompt.md) | PR-DFD-02 | active | PASS |
| 3.2 | [prompts/dfd/03-boundary-extract.prompt.md](../prompts/dfd/03-boundary-extract.prompt.md) | PR-DFD-03 | active | PASS |
| 3.3 | [prompts/dfd/04-component-extract.prompt.md](../prompts/dfd/04-component-extract.prompt.md) | PR-DFD-04 | active | PASS |
| 3.4 | [prompts/dfd/05-flow-extract.prompt.md](../prompts/dfd/05-flow-extract.prompt.md) | PR-DFD-05 | active | PASS |
| 3.5 | [prompts/dfd/06-annotation-resolve.prompt.md](../prompts/dfd/06-annotation-resolve.prompt.md) | PR-DFD-06 | active | PASS |
| 3.6 | [prompts/dfd/07-boundary-crossing-detect.prompt.md](../prompts/dfd/07-boundary-crossing-detect.prompt.md) | PR-DFD-07 | active | PASS |
| 3.7 | [prompts/dfd/08-control-signal-detect.prompt.md](../prompts/dfd/08-control-signal-detect.prompt.md) | PR-DFD-08 | active | PASS |
| 3.8 | [prompts/dfd/09-confidence-score.prompt.md](../prompts/dfd/09-confidence-score.prompt.md) | PR-DFD-09 | active | PASS |
| 3.9 | [prompts/dfd/10-dfd-extraction-summarize.prompt.md](../prompts/dfd/10-dfd-extraction-summarize.prompt.md) | PR-DFD-10 | active | PASS |
| 3.10 | DFD prompt count = 9 | PASS | inventory above |
| 3.11 | DFD numbering preserves 02-10 (no DFD-01 prompt) | PASS | founder decision Q4 |

## 4. Total prompt count

| # | Check | Status | Evidence |
|---|---|---|---|
| 4.1 | Total prompt count = 23 (14 RS + 9 DFD) | PASS | Sections 2 and 3 |
| 4.2 | No prompt cards exist outside `prompts/rs/` and `prompts/dfd/` | PASS | only `prompts/README.md`, `prompts/prompt-registry.yaml`, `prompts/rs/`, `prompts/dfd/` are populated |
| 4.3 | Founder decision Q1 honored: PR-RS-07 writes both `{{output_root}}/09-missing-facts.md` and `{{output_root}}/12-targeted-questions.md` | PASS | [prompts/rs/07-missing-fact-question-generate.prompt.md](../prompts/rs/07-missing-fact-question-generate.prompt.md) Section 5 |
| 4.4 | Founder decision Q2 honored: PR-RS-00 has status `planned` and writes no output | PASS | [prompts/rs/00-run-full-chain.prompt.md](../prompts/rs/00-run-full-chain.prompt.md) Sections 1 and 5 |

## 5. Required prompt sections

Every prompt card must contain all 11 required sections in order: 1. Identity, 2. Purpose, 3. Run Profile Inputs, 4. Required Read Paths, 5. Required Output, 6. Instructions, 7. Stop Conditions, 8. Unknown Handling, 9. Evidence / Run-Log Guidance, 10. Direct Prompt Test, 11. Not In Scope.

| # | Check | Status | Evidence |
|---|---|---|---|
| 5.1 | Every RS prompt card contains all 11 sections | PASS | each card uses the standard 11-section structure |
| 5.2 | Every DFD prompt card contains all 11 sections | PASS | each card uses the standard 11-section structure |
| 5.3 | Section 1 (Identity) lists prompt_id, prompt_name, owning_build_package, prompt_family, status, future_skill_id, future_pra_owner, and review_step or dfd_step | PASS | YAML front matter plus identity bullets |
| 5.4 | Section 11 (Not In Scope) lists no skill/PRA/adapter/Jira/Confluence/Rovo/MCP execution, no scoring (except RS-13), no diagram, no release/export, no runtime/cloud/database execution | PASS | enforced uniformly across all 23 cards |

## 6. Variable contract

| # | Check | Status | Evidence |
|---|---|---|---|
| 6.1 | Every prompt's Section 3 references `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` | PASS | 23 cards |
| 6.2 | No prompt hardcodes `run_id`, `sample_id`, `input_root`, `expected_root`, `output_root`, source/destination URLs, `output_destination_mode`, or `postback_execution_status` | PASS | all path/URL references use `{{...}}` placeholders |
| 6.3 | No prompt invents a run-profile field outside [config/run-profile.schema.yaml](../config/run-profile.schema.yaml) | PASS | only schema-defined fields are referenced |
| 6.4 | No prompt requires reading the old reference workspace | PASS | no card references `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` for read |

## 7. Output discipline

| # | Check | Status | Evidence |
|---|---|---|---|
| 7.1 | Every prompt's Section 5 lists output(s) only under `{{output_root}}` | PASS | RS outputs land at `{{output_root}}/01..17`; DFD outputs land at `{{output_root}}/dfd/01..09` |
| 7.2 | RS output filenames match Package 04 contract (`01-input-inventory.md` through `17-accuracy-score.md`) | PASS | mapping documented in [prompts/rs/README.md](../prompts/rs/README.md) |
| 7.3 | DFD output filenames match Package 04 contract (`dfd/01-intake-quality-check.md` through `dfd/09-extraction-summary.md`) | PASS | mapping documented in [prompts/dfd/README.md](../prompts/dfd/README.md) |
| 7.4 | The wrapper prompt (PR-RS-00) writes no output | PASS | [prompts/rs/00-run-full-chain.prompt.md](../prompts/rs/00-run-full-chain.prompt.md) Section 5 |
| 7.5 | The accuracy-score prompt (PR-RS-13) is the only prompt that may write a `qualitative_score` | PASS | other prompts use `confidence` only and explicitly defer scoring |

## 8. Future-reference discipline

| # | Check | Status | Evidence |
|---|---|---|---|
| 8.1 | No prompt requires a Build Package 05 artifact (skill contract) as a hard read | PASS | Skills are listed only as "Future-package references (not required; do not stop on absence)" |
| 8.2 | No prompt requires a Build Package 06 artifact (PRA spec or `.agent.md` adapter) as a hard read | PASS | PRAs and adapters listed only as future references |
| 8.3 | No prompt requires a Build Package 07 artifact (catalog) as a hard read | PASS | Catalogs listed only as future references; legend normalization is performed from source visible content, not catalog imports |
| 8.4 | No prompt requires a Build Package 08 artifact (blueprint) as a hard read; PR-RS-09 records `no_blueprint_available` honestly when no blueprint exists | PASS | [prompts/rs/09-blueprint-match.prompt.md](../prompts/rs/09-blueprint-match.prompt.md) Sections 4 and 6 |
| 8.5 | No prompt requires a Build Package 09 artifact (template) as a hard read | PASS | Templates listed only as future references |
| 8.6 | No prompt requires a Build Package 10 artifact (sample / expected baseline) as a hard read; PR-RS-13 stops cleanly with `scoring_status: not_applicable_for_this_run` when `{{expected_root}}` is empty | PASS | [prompts/rs/13-accuracy-score.prompt.md](../prompts/rs/13-accuracy-score.prompt.md) Sections 6 and 7 |

## 9. Stop / unknown / direct-test completeness

| # | Check | Status | Evidence |
|---|---|---|---|
| 9.1 | Every prompt has Stop Conditions covering missing run-profile, unresolved variables, sensitive data, writes outside `{{output_root}}`, old-reference touch, future-package hard read, and external-execution claim | PASS | uniform Section 7 |
| 9.2 | Every prompt has Unknown Handling that prefers `unknown` over invention | PASS | uniform Section 8 |
| 9.3 | Every prompt has a Direct Prompt Test block with `tools/New-AisrafRun.ps1` and/or `tools/Test-AisrafRunProfile.ps1` invocation, expected artifact path, and PASS criteria | PASS | uniform Section 10 |
| 9.4 | Every prompt's Evidence / Run-Log Guidance forbids pre-writing the run-log entry, forbids external-post-back claims, and ties the entry to human acceptance | PASS | uniform Section 9 |

## 10. No-drift gates

| # | Check | Status | Evidence |
|---|---|---|---|
| 10.1 | No skill contracts created in Build Package 04 | PASS | `skills/` contains only `README.md` |
| 10.2 | No PRA specifications or `prototype-agent-registry.yaml` created | PASS | `prototype-agents/` contains only `README.md` |
| 10.3 | No `.agent.md` adapters created | PASS | `.agents/` contains only `README.md`; no `*.agent.md` files anywhere |
| 10.4 | No catalogs created | PASS | `catalogs/` contains only `README.md` |
| 10.5 | No blueprints created | PASS | `blueprints/` contains only `README.md` |
| 10.6 | No templates created beyond authoring-agent templates | PASS | `templates/` contains only `README.md` |
| 10.7 | No samples or expected baselines created | PASS | `samples/` contains only `README.md` |
| 10.8 | No run outputs created | PASS | `runs/` contains only `README.md` (no `RUN-*/` folders committed) |
| 10.9 | No diagrams created | PASS | `diagrams/` contains only `README.md` |
| 10.10 | No docs/runbooks created | PASS | `docs/` contains only `README.md` |
| 10.11 | No release artifacts created | PASS | `release/` contains only `README.md`; no DOCX/PDF/PPTX/ZIP anywhere |
| 10.12 | No schemas outside `config/` created | PASS | `config/run-profile.schema.yaml` remains the only schema |
| 10.13 | No runtime code, cloud assets, or external-connector proof created | PASS | no scripts beyond the three approved Build Package 03 tools |
| 10.14 | Old reference workspace untouched | PASS | tools and prompts never write to `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` |

## 11. Tool compatibility update (founder-approved scope extension)

| # | Check | Status | Evidence |
|---|---|---|---|
| 11.1 | [tools/Test-AisrafPackage.ps1](../tools/Test-AisrafPackage.ps1) Check 08 split: `prompts/` removed from README-only set; `08b-prompts-content-limits` allows registry, sub-READMEs, and `*.prompt.md` cards under `rs/` and `dfd/` | PASS | tool patched per founder approval |
| 11.2 | [tools/Test-AisrafPackage.ps1](../tools/Test-AisrafPackage.ps1) Check 11 extended: `package-04-prompts-checklist.md` and `prompt-registry-checklist.md` added to the allowed validation file list | PASS | tool patched per founder approval |
| 11.3 | Tool synopsis/description advanced from "Build Package 01-03 surface" to "Build Package 01-04 surface" | PASS | comment block updated |
| 11.4 | No other tool behavior changed | PASS | path-discipline, sensitive-data, runtime-claim, binary-file, release-artifact, run-output, cloud, MCP, Jira, Confluence, no-drift gates intact |
| 11.5 | [validation/package-03-tools-checklist.md](package-03-tools-checklist.md) NOT modified | PASS | Package 03 acceptance evidence stays frozen |

## 12. Manifest and governance updates

| # | Check | Status | Evidence |
|---|---|---|---|
| 12.1 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) `package_state: prompts_active` | PASS | manifest patched |
| 12.2 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) `current_build_package` advanced to `04 / Prompts and prompt registry / active` | PASS | manifest patched |
| 12.3 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) `next_build_package` set to `05 / Skills and skill registry / next_allowed` | PASS | manifest patched |
| 12.4 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) `prompt_status: active` | PASS | manifest patched |
| 12.5 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) declares `build_package_04_allowed_writes` block | PASS | manifest patched |
| 12.6 | [validation/no-drift-rules.md](no-drift-rules.md) appended Build Package 04 entries | PASS | rules patched |
| 12.7 | [README.md](../README.md), [START-HERE.md](../START-HERE.md), [.github/copilot-instructions.md](../.github/copilot-instructions.md) advanced from "Package 01 only" to "Packages 01–04 committed; next is Package 05" | PASS | minimal status correction per founder Q3 |

## 13. Operator pre-commit gates

| # | Check | Status | Evidence |
|---|---|---|---|
| 13.1 | Working tree contains no `runs/RUN-*/` folder produced during Build Package 04 testing | TODO | requires human confirmation before commit |
| 13.2 | [tools/Test-AisrafPackage.ps1](../tools/Test-AisrafPackage.ps1) returns exit code 0 with no FAIL rows | PASS | run executed at end of Build Package 04 implementation |
| 13.3 | Operator review of [prompts/README.md](../prompts/README.md), the two family READMEs, and a sampling of prompt cards | TODO | requires human review |
| 13.4 | Operator confirms that founder decisions Q1, Q2, Q3, Q4 are honored | TODO | requires human review |

## 14. Next allowed Build Package

| # | Check | Status | Evidence |
|---|---|---|---|
| 14.1 | Next allowed Build Package is Build Package 05 — Skills and skill registry | PASS | [BUILD-ORDER.md](../BUILD-ORDER.md) and `next_build_package` in [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) |
