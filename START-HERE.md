# Start Here

Package: AISRAF SAS Prototype v0.1.2

This workspace has Build Packages 01–08 active. Build Package 08 (blueprints) is the most recent.

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

## Stop For Now

- Do not create diagrams yet (Build Package 13).
- Do not create release artifacts yet (Build Package 15).
- Do not create templates beyond authoring-agent templates (Build Package 09), samples (Build Package 10), run outputs (Build Package 11), runtime code, schemas outside `config/`, or cloud resources.
- Do not modify the Build Package 04 prompt registry, the Build Package 05 skill registry, the Build Package 06 prototype-agent registry, the Build Package 07 catalog registry, any prompt card, any skill contract, any PRA spec, any `.agent.md` adapter, or any catalog YAML.
- Do not invent new catalog vocabulary inline; catalog extension requires a future governed catalog update.
- Do not invent new blueprint identifiers, new match-state values, or controlled values inside a blueprint. Blueprint extension requires a future governed blueprint update.

## Next Build Package

The next allowed Build Package is **Build Package 09 — Templates**.
