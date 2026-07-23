---
description: "AEOS phase 65 — documentation & handover for a shipped change"
---

Run AEOS phase **65-documentation** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g3.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS`. If missing or
   `REJECTED`, STOP.
2. Read `aeos/prompts/65-documentation.md` and follow it exactly, drawing on the
   design, ADRs, contracts, and all reports.
3. Produce `.ai/reports/<change-id>/documentation.md` — an index/handover
   covering API docs, architecture docs, ADR index, deployment guide, runbooks,
   and developer guide (pointing to existing artifacts, not duplicating them).
4. Finish by telling the human: after deployment, run `openspec archive
   <change-id>` to fold spec deltas into `openspec/specs/`. The next change
   re-enters at `/aeos:requirements` with an impact-analysis note.
