---
description: "AEOS phase 10 — write the OpenSpec proposal for a change"
---

Run AEOS phase **10-proposal** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g0.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS`. If missing or
   `REJECTED`, STOP and tell the human gate G0 is missing.
2. Read `aeos/prompts/10-proposal.md` and follow it exactly, with `.ai/idea.md`
   and `openspec/specs/` as inputs.
3. Produce `openspec/changes/<change-id>/proposal.md`; run
   `openspec validate <change-id>` if the CLI is installed.
4. Finish by telling the human: approve the proposal, then `/aeos:design
   <change-id>`.
