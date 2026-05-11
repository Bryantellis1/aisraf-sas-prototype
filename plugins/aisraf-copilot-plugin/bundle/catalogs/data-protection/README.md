# catalogs/data-protection/

Family: data-protection.

Owning Build Package: Build Package 07 — Catalogs.

Cross-cutting note: [confidence-level-catalog.yaml](confidence-level-catalog.yaml) is `cross_cutting_catalog: true` with `primary_family: data-protection`. Although it lives here, it applies to DFD extraction, annotation resolution, component classification, boundary classification, finding confidence, and accuracy scoring.

## Purpose

The data-protection family defines the controlled vocabulary used to classify data class (C1–C5 plus PCI), transport protection, at-rest protection, and review confidence. It prevents reviewers from claiming encryption coverage, key management, or storage scope from a single visible marker, and from confusing transit protection with at-rest protection.

## Catalogs

| file | purpose |
|---|---|
| [data-class-catalog.yaml](data-class-catalog.yaml) | Closed list of data classes (C1–C5) plus PCI/PAN suffix and protection sub-markers (E#, T#, U#, H#) read inside C-tokens. |
| [transport-protection-catalog.yaml](transport-protection-catalog.yaml) | Closed list of transport-protection values driven by standalone T# tokens, HTTPS/TLS labels, and unknown. |
| [at-rest-protection-catalog.yaml](at-rest-protection-catalog.yaml) | Closed list of at-rest-protection values driven by R# tokens, storage-state words (Enc, Tok, Trun, NoCC, Clr), and unknown. |
| [confidence-level-catalog.yaml](confidence-level-catalog.yaml) | Cross-cutting: closed list of confidence levels (high, medium, low, unknown) and the rules for when each value applies. |

## Boundaries

- Transit and at-rest are different controls. A standalone `T#` is transit; `T#` inside a C-token (`C5T1P`) is tokenization. `R#` is at-rest. Catalogs enforce this separation.
- A storage-state word (`Enc`, `Tok`, `Trun`, `NoCC`, `Clr`) applies to its scoped store unless explicitly scoped otherwise. It does not propagate to all flows.
- Data class is recorded per material flow. Catalogs forbid classifying every flow as C5 by default and forbid propagating an artifact-level class header to flows.
- Encryption marker visibility does not prove key management, key rotation, key owner, CMEK, scope, or implementation evidence.

## Cross-References

- Every catalog in this family references [security-stacks/proof-vs-signal-rule-catalog.yaml](../security-stacks/proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- The confidence-level catalog is consumed by every other catalog and by all 8 PRAs and 7 adapters; consumer mapping is recorded in [../catalog-registry.yaml](../catalog-registry.yaml).
