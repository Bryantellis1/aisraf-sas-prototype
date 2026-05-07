# Build Package 05 — Skills And Skill Registry Checklist

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 05.
Skill registry authority: [skills/skill-registry.yaml](../skills/skill-registry.yaml)
Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml)
Validation authority: [config/run-profile.validation-rules.md](../config/run-profile.validation-rules.md)
No-drift authority: [validation/no-drift-rules.md](no-drift-rules.md)

This checklist is the acceptance gate for Build Package 05. Every required item must read PASS before Build Package 06 (Prototype agents, PRA specs, and `.agent.md` adapter model) may begin. FAIL items must be resolved or recorded as explicit blockers.

## 1. Skill-file presence

| # | Check | Status | Evidence |
|---|---|---|---|
| 1.1 | [skills/README.md](../skills/README.md) updated for Build Package 05 | PASS | active-package description, layout table, parameter contract, forbidden claims, compatibility notes, common mistakes |
| 1.2 | [skills/skill-registry.yaml](../skills/skill-registry.yaml) exists | PASS | this file present |
| 1.3 | [skills/rs/README.md](../skills/rs/README.md) exists | PASS | RS family overview present (17 contracts) |
| 1.4 | [skills/dfd/README.md](../skills/dfd/README.md) exists | PASS | DFD family overview present (9 contracts) |
| 1.5 | RS skill contracts exist (17) | PASS | see Section 2 inventory |
| 1.6 | DFD subskill contracts exist (9) | PASS | see Section 3 inventory |
| 1.7 | [validation/package-05-skills-checklist.md](package-05-skills-checklist.md) exists | PASS | this file |
| 1.8 | [validation/skill-registry-checklist.md](skill-registry-checklist.md) exists | PASS | sibling registry-only checklist |

## 2. RS skill inventory (17 files)

| # | File | Skill ID | Review Step | Mapped Prompt | Status |
|---|---|---|---|---|---|
| 2.1 | [skills/rs/SK-INPUT-PACKAGE-READ.md](../skills/rs/SK-INPUT-PACKAGE-READ.md) | SK-INPUT-PACKAGE-READ | RS-01 | PR-RS-01 | PASS |
| 2.2 | [skills/rs/SK-DFD-VISUAL-READ.md](../skills/rs/SK-DFD-VISUAL-READ.md) | SK-DFD-VISUAL-READ | RS-02 | PR-RS-02 | PASS |
| 2.3 | [skills/rs/SK-LEGEND-NORMALIZE.md](../skills/rs/SK-LEGEND-NORMALIZE.md) | SK-LEGEND-NORMALIZE | RS-03 | PR-RS-03 | PASS |
| 2.4 | [skills/rs/SK-COMPONENT-EXTRACT.md](../skills/rs/SK-COMPONENT-EXTRACT.md) | SK-COMPONENT-EXTRACT | RS-04 | PR-RS-04 | PASS |
| 2.5 | [skills/rs/SK-FLOW-EXTRACT.md](../skills/rs/SK-FLOW-EXTRACT.md) | SK-FLOW-EXTRACT | RS-05 | PR-RS-04 | PASS |
| 2.6 | [skills/rs/SK-BOUNDARY-CROSSING-DETECT.md](../skills/rs/SK-BOUNDARY-CROSSING-DETECT.md) | SK-BOUNDARY-CROSSING-DETECT | RS-06 | PR-RS-05 | PASS |
| 2.7 | [skills/rs/SK-SECURITY-STACK-ASSESS.md](../skills/rs/SK-SECURITY-STACK-ASSESS.md) | SK-SECURITY-STACK-ASSESS | RS-07 | PR-RS-05 | PASS |
| 2.8 | [skills/rs/SK-DATA-FLOW-TABLE-BUILD.md](../skills/rs/SK-DATA-FLOW-TABLE-BUILD.md) | SK-DATA-FLOW-TABLE-BUILD | RS-08 | PR-RS-06 | PASS |
| 2.9 | [skills/rs/SK-MISSING-FACT-IDENTIFY.md](../skills/rs/SK-MISSING-FACT-IDENTIFY.md) | SK-MISSING-FACT-IDENTIFY | RS-09 | PR-RS-07 | PASS |
| 2.10 | [skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md](../skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md) | SK-AI-ACTION-LEVEL-CLASSIFY | RS-10 | PR-RS-08 | PASS |
| 2.11 | [skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md](../skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md) | SK-REVIEW-BLUEPRINT-MATCH | RS-11 | PR-RS-09 | PASS |
| 2.12 | [skills/rs/SK-TARGETED-QUESTION-GENERATE.md](../skills/rs/SK-TARGETED-QUESTION-GENERATE.md) | SK-TARGETED-QUESTION-GENERATE | RS-12 | PR-RS-07 | PASS |
| 2.13 | [skills/rs/SK-FINDING-CLASSIFY.md](../skills/rs/SK-FINDING-CLASSIFY.md) | SK-FINDING-CLASSIFY | RS-13 | PR-RS-10 | PASS |
| 2.14 | [skills/rs/SK-RECOMMENDATION-WRITE.md](../skills/rs/SK-RECOMMENDATION-WRITE.md) | SK-RECOMMENDATION-WRITE | RS-14 | PR-RS-10 | PASS |
| 2.15 | [skills/rs/SK-HANDOFF-PACK-BUILD.md](../skills/rs/SK-HANDOFF-PACK-BUILD.md) | SK-HANDOFF-PACK-BUILD | RS-15 | PR-RS-11 | PASS |
| 2.16 | [skills/rs/SK-VALIDATION-NOTE-WRITE.md](../skills/rs/SK-VALIDATION-NOTE-WRITE.md) | SK-VALIDATION-NOTE-WRITE | RS-16 | PR-RS-12 | PASS |
| 2.17 | [skills/rs/SK-ACCURACY-SCORE.md](../skills/rs/SK-ACCURACY-SCORE.md) | SK-ACCURACY-SCORE | RS-17 | PR-RS-13 | PASS |
| 2.18 | RS skill count = 17 | PASS | inventory above |

## 3. DFD subskill inventory (9 files)

| # | File | Subskill ID | DFD Step | Mapped Prompt | Status |
|---|---|---|---|---|---|
| 3.1 | [skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md](../skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md) | SK-DFD-01-INTAKE-QUALITY-CHECK | DFD-01 | PR-DFD-02 | PASS |
| 3.2 | [skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md](../skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md) | SK-DFD-02-BOUNDARY-EXTRACT | DFD-02 | PR-DFD-03 | PASS |
| 3.3 | [skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md](../skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md) | SK-DFD-03-COMPONENT-EXTRACT | DFD-03 | PR-DFD-04 | PASS |
| 3.4 | [skills/dfd/SK-DFD-04-FLOW-EXTRACT.md](../skills/dfd/SK-DFD-04-FLOW-EXTRACT.md) | SK-DFD-04-FLOW-EXTRACT | DFD-04 | PR-DFD-05 | PASS |
| 3.5 | [skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md](../skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md) | SK-DFD-05-ANNOTATION-RESOLVE | DFD-05 | PR-DFD-06 | PASS |
| 3.6 | [skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md](../skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md) | SK-DFD-06-BOUNDARY-CROSSING-DETECT | DFD-06 | PR-DFD-07 | PASS |
| 3.7 | [skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md](../skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md) | SK-DFD-07-CONTROL-SIGNAL-DETECT | DFD-07 | PR-DFD-08 | PASS |
| 3.8 | [skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md](../skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md) | SK-DFD-08-CONFIDENCE-SCORE | DFD-08 | PR-DFD-09 | PASS |
| 3.9 | [skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md](../skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md) | SK-DFD-09-EXTRACTION-SUMMARIZE | DFD-09 | PR-DFD-10 | PASS |
| 3.10 | DFD subskill count = 9 | PASS | inventory above |

## 4. Total skill count and family parity

| # | Check | Status | Evidence |
|---|---|---|---|
| 4.1 | Total skill count = 26 | PASS | 17 RS + 9 DFD |
| 4.2 | Registry `skill_count: 26` | PASS | top of [skill-registry.yaml](../skills/skill-registry.yaml) |
| 4.3 | Registry `skill_family_counts.rs: 17` | PASS | top of file |
| 4.4 | Registry `skill_family_counts.dfd: 9` | PASS | top of file |
| 4.5 | PR-RS-00 wrapper deferred and not counted in 26 | PASS | recorded under `planned_future_skills` block; founder Q3 |

## 5. Required 14 sections per skill

Each contract contains all 14 sections in order: Identity, Purpose, Required Inputs, Optional Inputs, Required Outputs, Procedure, Stop Conditions, Unknown Handling, Confidence Handling, Critical Misses, Human Review Gate, Validation/Scoring Relationship, Direct Skill Test, Not In Scope.

| # | Check | Status | Evidence |
|---|---|---|---|
| 5.1 | Every RS skill contains all 14 sections | PASS | uniform structure |
| 5.2 | Every DFD subskill contains all 14 sections | PASS | uniform structure |
| 5.3 | Section order matches the canonical 14-section list | PASS | uniform numbering |

## 6. Run-profile variable usage

| # | Check | Status | Evidence |
|---|---|---|---|
| 6.1 | No skill hardcodes `run_id`, `sample_id`, paths, or URLs | PASS | every skill resolves variables from `runs/{{run_id}}/run-profile.yaml` |
| 6.2 | Every skill references the seven canonical run-profile variables only | PASS | `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| 6.3 | Every skill writes only under `{{output_root}}` (or `{{output_root}}/dfd/` for DFD) when invoked by its mapped prompt | PASS | Section 5 of every contract |
| 6.4 | No skill writes to `config/`, `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `diagrams/`, `docs/`, `release/`, `tools/`, or `validation/` | PASS | enforced by Section 7 stop conditions |
| 6.5 | No skill writes to the old reference workspace | PASS | enforced by Section 7 stop conditions |

## 7. Stop conditions

| # | Check | Status | Evidence |
|---|---|---|---|
| 7.1 | Every skill has a Stop Conditions section listing missing-input, unresolved-variable, sensitive-data, write-outside-output_root, unsupported-fact, external-execution-claim, and future-package-hard-dependency conditions | PASS | Section 7 of every contract |

## 8. Unknown handling

| # | Check | Status | Evidence |
|---|---|---|---|
| 8.1 | Every skill has an Unknown Handling section | PASS | Section 8 of every contract |
| 8.2 | Unknowns remain visible (not silently filled in or promoted) | PASS | rule stated in every contract |
| 8.3 | Material unknowns route forward (typically to `SK-MISSING-FACT-IDENTIFY` / RS-09) | PASS | downstream routing stated where applicable |

## 9. Confidence handling

| # | Check | Status | Evidence |
|---|---|---|---|
| 9.1 | Every skill has a Confidence Handling section | PASS | Section 9 of every contract |
| 9.2 | Every skill defines HIGH / MEDIUM / LOW / UNKNOWN guidance where applicable | PASS | DFD subskills and most RS skills |
| 9.3 | Skills that aggregate prior confidence values (e.g., `SK-DATA-FLOW-TABLE-BUILD`, `SK-HANDOFF-PACK-BUILD`) explicitly inherit and do not raise prior confidence | PASS | stated in Section 9 |

## 10. Critical misses

| # | Check | Status | Evidence |
|---|---|---|---|
| 10.1 | Every skill has a Critical Misses section | PASS | Section 10 of every contract |
| 10.2 | Every critical-miss list includes a "write outside `{{output_root}}`" entry | PASS | enforced by every contract |
| 10.3 | Skills that interact with baselines record "edited baseline under `{{expected_root}}`" or equivalent | PASS | `SK-INPUT-PACKAGE-READ`, `SK-ACCURACY-SCORE`, etc. |

## 11. Human review gate

| # | Check | Status | Evidence |
|---|---|---|---|
| 11.1 | Every skill has a Human Review Gate section | PASS | Section 11 of every contract |
| 11.2 | The gate names what the SAS reviewer must inspect before acceptance | PASS | Section 11 narrative in every contract |

## 12. Validation / scoring relationship

| # | Check | Status | Evidence |
|---|---|---|---|
| 12.1 | Every skill has a Validation / Scoring Relationship section | PASS | Section 12 of every contract |
| 12.2 | Expected-baseline references use the `(planned; defined in Build Package 10)` placeholder suffix | PASS | every Section 12 |
| 12.3 | Only `SK-ACCURACY-SCORE` produces an accuracy score | PASS | every other skill explicitly states "no accuracy scoring" |
| 12.4 | DFD-08 and DFD-09 explicitly disclaim accuracy scoring | PASS | Sections 10, 12, 14 of those contracts |

## 13. Direct skill test guidance

| # | Check | Status | Evidence |
|---|---|---|---|
| 13.1 | Every skill has a Direct Skill Test section with operator commands and PASS criteria | PASS | Section 13 of every contract |
| 13.2 | The direct test references the mapped Build Package 04 prompt card | PASS | every Section 13 |
| 13.3 | The expected local output path matches Section 5 | PASS | aligned in every contract |

## 14. Forbidden creations

| # | Check | Status | Evidence |
|---|---|---|---|
| 14.1 | No PRA specifications created | PASS | `prototype-agents/` contains only `README.md` |
| 14.2 | No `.agent.md` adapters created | PASS | Test-AisrafPackage Check 07 enforces this |
| 14.3 | No `prototype-agents/prototype-agent-registry.yaml` created | PASS | not present |
| 14.4 | No catalog content created (Build Package 07) | PASS | `catalogs/` contains only `README.md` |
| 14.5 | No blueprint content created (Build Package 08) | PASS | `blueprints/` contains only `README.md` |
| 14.6 | No template content beyond authoring-agent templates (Build Package 09) | PASS | `templates/` contains only `README.md` |
| 14.7 | No sample inputs or expected baselines created (Build Package 10) | PASS | `samples/` contains only `README.md` |
| 14.8 | No run outputs created (Build Package 11) | PASS | `runs/` contains only `README.md` |
| 14.9 | No diagram content created (Build Package 13) | PASS | `diagrams/` contains only `README.md` |
| 14.10 | No docs/runbook content created (Build Package 14) | PASS | `docs/` contains only `README.md` |
| 14.11 | No release artifacts created (Build Package 15) | PASS | no DOCX/PDF/PPTX/ZIP found |
| 14.12 | No schemas outside `config/` | PASS | no schemas authored in Build Package 05 |
| 14.13 | No prompts modified | PASS | `prompts/` is byte-identical to Build Package 04 commit |
| 14.14 | No old reference workspace writes | PASS | no edits to `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` |

## 15. Test-AisrafPackage.ps1 result

| # | Check | Status | Evidence |
|---|---|---|---|
| 15.1 | `tools/Test-AisrafPackage.ps1` returns 0 with no FAIL row | PASS | post-Build-Package-05 surgical patch |
| 15.2 | Check 08 no longer applies the README-only rule to `skills/` | PASS | `skills/` removed from `$readmeOnlyFolders` |
| 15.3 | New Check 08c-skills-content-limits passes | PASS | 17 RS + 9 DFD + READMEs + registry |
| 15.4 | Check 11 validation allowed-list includes the two new Package 05 files | PASS | extended list includes `package-05-skills-checklist.md` and `skill-registry-checklist.md` |
| 15.5 | Other Test-AisrafPackage behavior is unchanged | PASS | only the four authorized changes were applied |

## 16. Governance updates

| # | Check | Status | Evidence |
|---|---|---|---|
| 16.1 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) records Build Package 05 as `current_build_package` | PASS | manifest updated |
| 16.2 | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) records Build Package 06 as `next_build_package` | PASS | manifest updated |
| 16.3 | `build_package_05_allowed_writes` block exists in the manifest | PASS | manifest updated |
| 16.4 | [validation/no-drift-rules.md](no-drift-rules.md) contains Build Package 05 rules | PASS | updated |
| 16.5 | [README.md](../README.md) reflects active Build Package 05 status | PASS | updated |
| 16.6 | [START-HERE.md](../START-HERE.md) reflects active Build Package 05 status | PASS | updated |
| 16.7 | [.github/copilot-instructions.md](../.github/copilot-instructions.md) reflects active Build Package 05 status | PASS | updated |
| 16.8 | [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md) marks Root Area 07 (`skills/`) as active under Build Package 05 | PASS | updated |

## 17. Old reference workspace untouched

| # | Check | Status | Evidence |
|---|---|---|---|
| 17.1 | The old reference workspace (`D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01`) was read for context only | PASS | no writes |
| 17.2 | No file in the old reference workspace was modified, renamed, or deleted | PASS | no writes |
| 17.3 | No file from the old reference workspace was copied into the active workspace verbatim | PASS | skill bodies are rewritten for v0.1.2 model |

## 18. Next allowed Build Package

| # | Check | Status | Evidence |
|---|---|---|---|
| 18.1 | Next allowed Build Package = Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model | PASS | recorded in [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) |
| 18.2 | No later-package work (catalogs, blueprints, samples, runs, diagrams, docs, release) was started | PASS | folders are README-only or have only Build Package 01-05 content |

## Conclusion

If every row above reads PASS, Build Package 05 is human-review-ready. The package may proceed to git stage and commit only after a human reviewer signs off on this checklist and confirms no untracked artifacts remain. If any row reads FAIL, that row must be resolved or recorded as an explicit blocker before Build Package 06 begins.
