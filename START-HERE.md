# Start Here

Package: AISRAF SAS Prototype v0.1.2

## Autonomy Terms In Plain English

- **AL means Autonomy Level:** how autonomous the user experience is.
- **AM means Autonomy Mode / release evidence lane:** how AISRAF proves that autonomy capability.
- **Mode 0:** preview/read-only; no writes.
- **Mode 1 / AL2:** everyday controlled-output local workbench.
- **Mode 2 / AM3 / AL3:** local orchestrated runtime evidence path.
- **Mode 3:** maintainer validation and release QA.
- **Mode 4 / AM4:** future external adapter/post-back execution.
- **AL5:** closed-loop autonomy; out of scope.

AISRAF v0.1.2 proves AM3 / AL3 local orchestrated multi-agent runtime evidence. AM3 evidence is local-only, human-gated, validator-backed, and evidence-bound. This is an evidence-path claim, not a claim of full specialist-generated review output execution, production readiness, publication, or AM4 integration.

Gate state: REL0 remediation baseline commit `abcad6feb16a94ed71c81f6620032584f22e5a68` is the accepted technical candidate for this release-decision remediation pass. The current gate is **WP-12C-REL0-RELEASE-DECISION-REMEDIATION**; next is **WP-12C-REL0-RELEASE-DECISION-RERUN**. WP-13, AM4, push, and publish remain blocked until the REL0 release decision and push-prep gates pass.

The everyday security architect and application architect workflow remains a local controlled-output workbench. AISRAF does not execute external adapters or post back to Jira, Confluence, Lucidchart, Rovo, MCP, Azure AI Foundry, Google ADK, Microsoft Agent Framework, databases, Terraform, cloud runtimes, event buses, or telemetry systems (AM4 / AL4, future). AL5 closed-loop autonomy is out of scope.

## Review Journey In One Pass

1. Load or open the AISRAF package/plugin from this workspace or its local provider surface.
2. In the provider surface, expect the AISRAF agents, provider Agent Skills, and hook configuration; start with `@aisraf-orchestrator`.
3. Create or use a run folder at `runs/<run_id>/`.
4. Put DFD/design package inputs under `runs/<run_id>/inputs/`.
5. Control the run with `runs/<run_id>/run-profile.yaml`.
6. Receive local Markdown outputs: `00-run-log.md`, `01-input-inventory.md` through `17-accuracy-score.md`, plus the DFD outputs under `dfd/01` through `dfd/09`.
7. Use a separate `runs/<run_id>/` folder for each separate DFD or review.
8. v0.1.2 performs no external post-back; AM4 external adapter execution remains future only.

License and notice posture: `LICENSE` and `NOTICE.md` are placeholder / evaluation-only / all-rights-reserved documents pending founder/legal confirmation. Public publication remains blocked unless the founder explicitly accepts that placeholder posture for the release lane.

Release journey modes:

| Mode | v0.1.2 status |
|---|---|
| Mode 0 - read/preview, no writes | Current preview path for inspecting roles, expected reads/writes, run profiles, and release evidence without modifying files. |
| Mode 1 - AL2 controlled-output workbench | Current everyday security architect and application architect workflow. Outputs are local governed Markdown under an approved run folder. |
| Mode 2 - AM3 / AL3 local orchestrated runtime evidence | Current release-visible local runtime journey/proof path. AISRAF Orchestrator owns run-state and event log; AM3-01 through AM3-06 handoffs and human gates are represented in local-only evidence. |
| Mode 3 - maintainer validation and release QA | Current maintainer path for package validators, release manifests, blocker registers, bundle checksum validation, and QA closeout. |
| Mode 4 - AM4 external adapter / post-back execution | Future only. Jira, Confluence, Lucidchart, Rovo, MCP, cloud, database, Terraform, event bus, telemetry, and post-back execution are not current behavior. |

AL5 closed-loop autonomy remains out of scope.

## v0.1.2 Release — Read First

Pick the entrypoint that matches your role.

- **New evaluator** — start with [docs/AISRAF-PRIMER.md](docs/AISRAF-PRIMER.md).
- **Operator** — start with [docs/OPERATOR-QUICKSTART.md](docs/OPERATOR-QUICKSTART.md).
- **Security architect** — start with [docs/SECURITY-REVIEW-WORKFLOW.md](docs/SECURITY-REVIEW-WORKFLOW.md).
- **Maintainer** — read [docs/ARCHITECTURE-OVERVIEW.md](docs/ARCHITECTURE-OVERVIEW.md) and [RELEASE-MANIFEST.yaml](RELEASE-MANIFEST.yaml).
- **Roadmap reader** — read [docs/ROADMAP.md](docs/ROADMAP.md).

Release state: Build Packages 01–12 are governed and validator-green. BP12C operator-experience and plugin-packaging increments through WP-12C-REL0-B are committed. WP-12C-AM3-QA accepted only the bounded local runtime evidence claim. REL0 final QA remediation closed at `abcad6feb16a94ed71c81f6620032584f22e5a68`; the active gate is **WP-12C-REL0-RELEASE-DECISION-REMEDIATION**. Next is **WP-12C-REL0-RELEASE-DECISION-RERUN**. WP-13 release visuals, push, publish, and AM4 adapter work remain blocked / future until the REL0 release decision and push-prep gates pass.

AM3 boundary: AISRAF Orchestrator owns run-state and event log. Specialist handoffs are represented by AM3-01 through AM3-06 request/response pairs. Human gates remain required. AM4 external adapter execution remains future. The local smoke evidence under `runs/RUN-SMOKE-AM3-001/` must not be staged or published in this gate.

> **Carried-forward blocker.** `BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder) records a defect in the canonical sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`/`.mmd` and the byte-copies under `runs/RUN-001/inputs/`). Build Package 13 (Diagrams) is also separately gated by founder-approved Package 10A / 11A correction OR sample-002 with a clean DFD. See [validation/sample-input-readiness-checklist.md](validation/sample-input-readiness-checklist.md) for the full defect statement and gate verdicts.

## Contributor / Package Authoring — Operator Steps

1. Open this folder as the VS Code workspace root: `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`.
2. Read [README.md](README.md).
3. Read [PROTOTYPE-CHARTER.md](PROTOTYPE-CHARTER.md).
4. Read [BUILD-ORDER.md](BUILD-ORDER.md).
5. Read [FOLDER-CONTRACTS.md](FOLDER-CONTRACTS.md) before authoring later package content.
6. Browse [prompts/README.md](prompts/README.md) to see the 23 canonical prompt cards available in Build Package 04.
7. Browse [skills/README.md](skills/README.md) to see the 26 canonical skill contracts available in Build Package 05.
8. Browse [prototype-agents/README.md](prototype-agents/README.md) to see the 8 PRA specs introduced in Build Package 06, and [.agents/README.md](.agents/README.md) for the 7 local Copilot adapter wrappers.
9. Browse [catalogs/README.md](catalogs/README.md) to see the 24 controlled-vocabulary catalogs introduced in Build Package 07 across 7 families (components, interactions, boundaries, identity-access, data-protection, security-stacks, review), and [catalogs/catalog-registry.yaml](catalogs/catalog-registry.yaml) for the consumer mapping.
10. Browse [blueprints/README.md](blueprints/README.md) to see the 9 controlled YAML blueprints introduced in Build Package 08 (8 under [blueprints/platform-independent/](blueprints/platform-independent/) and 1 under [blueprints/cloud-patterns/](blueprints/cloud-patterns/)), and [blueprints/blueprint-registry.yaml](blueprints/blueprint-registry.yaml) for the blueprint→catalog, blueprint→skill, blueprint→PRA, blueprint→adapter, and blueprint→prompt consumer maps.
11. Browse [templates/README.md](templates/README.md) to see the 31 reusable output-shape templates introduced in Build Package 09 across four family folders ([templates/output/](templates/output/) — 27 templates, [templates/jira/](templates/jira/) — 1 template, [templates/confluence/](templates/confluence/) — 1 template, [templates/run/](templates/run/) — 2 row templates), and [templates/template-registry.yaml](templates/template-registry.yaml) for the template→prompt, template→skill, template→PRA, template→adapter, template→blueprint, and template→catalog consumer maps.
12. Browse [samples/README.md](samples/README.md) and [samples/sample-001-dfd-crop/README.md](samples/sample-001-dfd-crop/README.md) to see the Build Package 10 sample set: one active gold-standard scored sample (`sample-001-dfd-crop` — AI SaaS Security Review Portal), six synthetic inputs, and 26 Markdown expected baselines (17 RS + 9 DFD) mirroring Package 09 templates. Samples 002–008 are recorded as `planned_or_deferred_samples` entries inside [samples/sample-registry.yaml](samples/sample-registry.yaml) only — no folders or files exist for them. Samples are test fixtures, not runs; numeric scoring is qualitative (`PASS_READY_FOR_REVIEW`) until the chain executes against the Build Package 11 run fixture and numeric scoring activates.
13. Browse [runs/README.md](runs/README.md) and [runs/RUN-001/README.md](runs/RUN-001/README.md) to see the Build Package 11 run-evidence model: the first canonical governed run fixture `runs/RUN-001/` for `sample-001-dfd-crop`, with [runs/RUN-001/run-profile.yaml](runs/RUN-001/run-profile.yaml) (Build Package 02 schema-compliant), [runs/RUN-001/00-run-log.md](runs/RUN-001/00-run-log.md) (Build Package 09 file-shape compliant), 6 byte-copies of the sample-001 inputs under `runs/RUN-001/inputs/`, and an empty governed `runs/RUN-001/dfd/` folder reserved for the 9 DFD subskill outputs. The 17 RS chain outputs at the run-folder root and the 9 DFD outputs under `dfd/` are reserved future paths — Build Package 11 does NOT execute the chain and does NOT produce any of the 26 outputs. The run-folder shape is pinned in [validation/run-folder-shape-checklist.md](validation/run-folder-shape-checklist.md), the run-log shape in [validation/run-log-checklist.md](validation/run-log-checklist.md), and the comparison/scoring procedure in [validation/run-comparison-checklist.md](validation/run-comparison-checklist.md). Other `runs/RUN-*` folders are smoke runs and must be removed before human git stage.
14. Read [validation/README.md](validation/README.md) — the Build Package 12 validation taxonomy index — for the 8-category gate model (package, registry, chain, sample, run, cross-cutting hygiene, forward, final QA), the run order (1 → 2 → 3 → 4 → 5 → 6 → 7 → 8), and the BLOCKERS section naming `BP12-SAMPLE-DFD-BLOCKER`. Build Package 12 added 10 new validation files plus 14 numbered amendments in [validation/no-drift-rules.md](validation/no-drift-rules.md). The empty governed folder `runs/RUN-001/dfd/` now carries `.gitkeep` as a fresh-clone reservation marker. Build Package 13 (Diagrams) is BLOCKED behind `BP12-SAMPLE-DFD-BLOCKER` resolution.

## Stop For Now

- Do not create diagrams yet (Build Package 13).
- Do not create release artifacts yet (Build Package 15).
- Do not execute the Build Package 04–09 chain against `runs/RUN-001/` as part of Build Package 11 — chain execution is operator-driven and produces the 26 reserved outputs only when run.
- Do not create the 17 RS chain outputs (`runs/RUN-001/01-input-inventory.md` through `17-accuracy-score.md`) or the 9 DFD outputs (`runs/RUN-001/dfd/dfd-01-intake-quality-check.md` through `dfd-09-extraction-summary.md`) inside Build Package 11 — those are reserved future paths.
- Do not create a second governed run fixture (`runs/RUN-002/` and beyond) inside Build Package 11.
- Do not create folders or files for `sample-002` through `sample-008` — they remain registry-only `planned_or_deferred_samples` entries until a future governed sample-expansion package.
- Do not modify the Build Package 04 prompt registry, the Build Package 05 skill registry, the Build Package 06 prototype-agent registry, the Build Package 07 catalog registry, the Build Package 08 blueprint registry, the Build Package 09 template registry, the Build Package 10 sample registry, any prompt card, any skill contract, any PRA spec, any `.agent.md` adapter, any catalog YAML, any blueprint YAML, any template Markdown, any sample input, any expected baseline, `tools/New-AisrafRun.ps1`, or `tools/Test-AisrafRunProfile.ps1`.
- Do not invent new catalog vocabulary inline; catalog extension requires a future governed catalog update.
- Do not invent new blueprint identifiers, new match-state values, or controlled values inside a blueprint. Blueprint extension requires a future governed blueprint update.
- Do not invent new templates beyond the 31 locked Build Package 09 templates; template extension requires a future governed template update.
- Do not enumerate catalog values inside a template body or sample expected-baseline body. Use `<value-from-catalogs/...>` placeholder style.
- Do not introduce non-schema run-profile placeholders (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`) anywhere.
- Do not add JSON expected baselines (founder decision Q1: Markdown-only).
- Do not create `expected-00-run-log.md` inside any sample folder — run logs belong to Build Package 11 (founder decision Q2).

## Next Build Package

The immediate governed gate is **WP-12C-REL0-RELEASE-DECISION-REMEDIATION**. If remediation passes, the next gate is **WP-12C-REL0-RELEASE-DECISION-RERUN**. WP-13 release visuals, push, publish, and AM4 adapter work remain blocked until the REL0 release decision and push-prep gates pass.

**AM4 adapter work** (Jira, Confluence, Lucidchart, Rovo, MCP, Foundry, ADK, MAF, database, Terraform, cloud, event bus, telemetry, post-back execution) is future and not part of the current v0.1.2 claim.
