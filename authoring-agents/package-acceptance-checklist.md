# Build Package Acceptance Checklist

Use this checklist before accepting any Build Package as complete.

## Package Identity

- [ ] Build Package number and name match [BUILD-ORDER.md](../BUILD-ORDER.md).
- [ ] Build Package purpose aligns with [PROTOTYPE-CHARTER.md](../PROTOTYPE-CHARTER.md).
- [ ] Build Package artifacts stay inside the allowed folder contracts.

## Build Contract

- [ ] Allowed writes are explicit.
- [ ] Prohibited writes are explicit.
- [ ] Source references are explicit.
- [ ] Stop conditions are explicit.
- [ ] Build Package dependencies are satisfied.

## Artifact Quality

- [ ] Files are named consistently.
- [ ] Content is clear and useful.
- [ ] No filler or unsupported claims are present.
- [ ] Deferred work is described as deferred.
- [ ] Old reference content was not copied blindly.

## No-Drift Gate

- [ ] No unlisted files were created.
- [ ] No later Build Package artifacts were created early.
- [ ] No hidden validation reports were created.
- [ ] No release, runtime, integration, or cloud proof is claimed without evidence.

## Acceptance Result

- [ ] PASS
- [ ] PARTIAL_WITH_ISSUES
- [ ] FAIL

Notes:

- `<notes>`
