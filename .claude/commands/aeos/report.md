---
description: "AEOS phase 55 — automated testing: produce the test coverage report"
---

Run AEOS phase **55-testing** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g2.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS`. If missing or
   `REJECTED`, STOP.
2. Read `aeos/prompts/55-testing.md` and follow it exactly; generate and run
   unit/integration/API/UI/E2E tests as the modules warrant, measuring against
   every handover's Testing Expectations, using the adapter's test commands.
3. Produce `.ai/reports/<change-id>/report-test-coverage.md` — real numbers or
   explicit gaps.
4. Finish by telling the human: this feeds the release-readiness report
   (`/aeos:review <change-id> release-readiness`) and gate **G3**.
