---
description: "AEOS phase 60 — review reports: code / integration / security / performance / release-readiness"
---

Run AEOS phase **60-review** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g2.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS` (parallel dev was
   authorized). If missing or `REJECTED`, STOP.
2. Read `aeos/prompts/60-review.md`. Determine which review to run from the
   arguments (code-review / integration / security / performance /
   release-readiness); ask the human if not given.
3. Produce `.ai/reports/<change-id>/report-<type>.md` from the matching template
   in `aeos/templates/`. Verdicts need evidence (location + recommendation).
4. When all reports exist (including `/aeos:report` test coverage), tell the
   human: decide gate **G3** → `.ai/reviews/<change-id>-g3.md`. After G3:
   `/aeos:docs <change-id>`, deploy, then `openspec archive <change-id>`.
