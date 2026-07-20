---
description: "AEOS phase 80 — produce the test coverage report"
---

Run AEOS phase **80-testing** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g1.md` exists with
   `Decision: APPROVED`. If not, STOP.
2. Read `aeos/prompts/80-testing.md` and follow it exactly; measure against
   every handover's §11 Testing Expectations, using the adapter's test
   commands.
3. Produce `.ai/reports/<change-id>/report-test-coverage.md` — real numbers or
   explicit gaps.
4. Finish by telling the human: this feeds the release-readiness report
   (`/aeos:review <change-id> release-readiness`) and gate **G2**.
