# Start Here

Package: AISRAF SAS Prototype v0.1.2

This workspace has Build Packages 01–10 active. Build Package 10 (samples and expected baselines) is the most recent.

## Operator Steps

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
12. Browse [samples/README.md](samples/README.md) and [samples/sample-001-dfd-crop/README.md](samples/sample-001-dfd-crop/README.md) to see the Build Package 10 sample set: one active gold-standard scored sample (`sample-001-dfd-crop` — AI SaaS Security Review Portal), six synthetic inputs, and 26 Markdown expected baselines (17 RS + 9 DFD) mirroring Package 09 templates. Samples 002–008 are recorded as `planned_or_deferred_samples` entries inside [samples/sample-registry.yaml](samples/sample-registry.yaml) only — no folders or files exist for them. Samples are test fixtures, not runs; numeric scoring is qualitative (`PASS_READY_FOR_REVIEW`) until Build Package 11 run execution validates numeric scoring.

## Stop For Now

- Do not create diagrams yet (Build Package 13).
- Do not create release artifacts yet (Build Package 15).
- Do not create live run outputs yet (Build Package 11), runtime code, schemas outside `config/`, or cloud resources.
- Do not create folders or files for `sample-002` through `sample-008` — they remain registry-only `planned_or_deferred_samples` entries until a future governed sample-expansion package.
- Do not modify the Build Package 04 prompt registry, the Build Package 05 skill registry, the Build Package 06 prototype-agent registry, the Build Package 07 catalog registry, the Build Package 08 blueprint registry, the Build Package 09 template registry, any prompt card, any skill contract, any PRA spec, any `.agent.md` adapter, any catalog YAML, any blueprint YAML, or any template Markdown.
- Do not invent new catalog vocabulary inline; catalog extension requires a future governed catalog update.
- Do not invent new blueprint identifiers, new match-state values, or controlled values inside a blueprint. Blueprint extension requires a future governed blueprint update.
- Do not invent new templates beyond the 31 locked Build Package 09 templates; template extension requires a future governed template update.
- Do not enumerate catalog values inside a template body or sample expected-baseline body. Use `<value-from-catalogs/...>` placeholder style.
- Do not introduce non-schema run-profile placeholders (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`) anywhere.
- Do not add JSON expected baselines (founder decision Q1: Markdown-only).
- Do not create `expected-00-run-log.md` inside any sample folder — run logs belong to Build Package 11 (founder decision Q2).

## Next Build Package

The next allowed Build Package is **Build Package 11 — Runs and execution evidence model**.
