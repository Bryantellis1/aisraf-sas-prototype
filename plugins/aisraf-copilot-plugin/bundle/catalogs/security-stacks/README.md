# catalogs/security-stacks/

Family: security-stacks.

Owning Build Package: Build Package 07 — Catalogs.

Cross-cutting note: [proof-vs-signal-rule-catalog.yaml](proof-vs-signal-rule-catalog.yaml) is `global_rule: true` and `applies_to_all_catalogs: true`. Although it lives here, it is referenced by every other catalog in `evidence_rules` and applies whenever a reviewer is tempted to convert a visible marker into implementation proof.

## Purpose

The security-stacks family defines the controlled vocabulary used to record visible stack markers (diamonds, gateways, policy checkpoints, logging, encryption, secret/key management) as review signals, and the global rules that prevent any of those markers from being treated as implementation proof.

## Catalogs

| file | purpose |
|---|---|
| [security-stack-marker-catalog.yaml](security-stack-marker-catalog.yaml) | Closed list of visible stack-marker forms: stack diamond, gateway/policy checkpoint, identity checkpoint, logging checkpoint, encryption checkpoint, secret-management marker, SSH/SFTP/SCP protocol marker, and unknown. |
| [control-signal-catalog.yaml](control-signal-catalog.yaml) | Closed list of derived control signals (visible/partial/missing/unknown) used as review inputs to finding classification. |
| [proof-vs-signal-rule-catalog.yaml](proof-vs-signal-rule-catalog.yaml) | Global rule catalog. Defines the difference between review signal and implementation proof for every other family. |

## Boundaries

- A diamond is a review signal, not an approved-stack confirmation. A gateway is a review signal, not authorization enforcement. A logging icon is a review signal, not monitoring effectiveness.
- A protocol marker (SSH/SFTP/SCP) is not a security stack. `S#` does not set `security_stack_present: true`.
- A secret-management marker (Secret Manager, KMS, key vault) is a review signal, not key-management proof, key rotation evidence, or coverage proof.
- Control signals (visible/partial/missing/unknown) are never converted to control-effectiveness claims inside a catalog; effectiveness/finding logic lives under [review/](../review/) and the future blueprint package.

## Cross-References

- Every other catalog in `catalogs/` references this family's [proof-vs-signal-rule-catalog.yaml](proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- Confidence values come from [data-protection/confidence-level-catalog.yaml](../data-protection/confidence-level-catalog.yaml).
