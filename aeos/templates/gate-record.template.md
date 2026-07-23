---
artifact: gate-record
phase: gate
owner: human
inputs: ["artifacts under review (see gate definition in aeos/workflows/gates.md)"]
outputs: [".ai/reviews/<change-id>-g<n>.md"]
purpose: Version-control a human gate decision so downstream phases can verify it.
validation: Decision is one of APPROVED / APPROVED-WITH-CONDITIONS / REJECTED; approver and date present.
---

# Gate Record: <change-id> — G<n>

- **Gate:** G<n> (<idea G0 | design G1 | foundation G2 | release G3>)
- **Change:** `<change-id>`
- **Approver:** <name / role>
- **Date:** <YYYY-MM-DD>

## Artifacts Reviewed
<!-- Exact paths reviewed at this gate. -->

## Decision
Decision: <APPROVED | APPROVED-WITH-CONDITIONS | REJECTED>

## Conditions
<!-- Required if APPROVED-WITH-CONDITIONS; each becomes a task before the next gate. -->

## Notes
<!-- Rationale, risks accepted, follow-ups. -->
