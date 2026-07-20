---
description: "AEOS phase 70 — produce review report artifacts and gate records"
---

Run AEOS phase **70-review** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g1.md` exists with
   `Decision: APPROVED` (Stage 2 must have been authorized). If not, STOP.
2. Read `aeos/prompts/70-review.md`. Ask the human which review to run (code
   review / security / performance / integration / release readiness) if not
   given in the arguments.
3. Produce `.ai/reports/<change-id>/report-<type>.md` from the matching
   template in `aeos/templates/`. Verdicts need evidence.
4. When all six reports exist (including `/aeos:report` outputs), tell the
   human: decide gate **G2** → `.ai/reviews/<change-id>-g2.md`. After G2:
   deploy, then `openspec archive <change-id>`.
