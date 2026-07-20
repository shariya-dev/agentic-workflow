---
description: "AEOS phase 00 — capture the business idea into .ai/idea.md"
---

Run AEOS phase **00-discovery** for: $ARGUMENTS

1. Read `aeos/prompts/00-discovery.md` and follow it exactly.
2. No gate precedes this phase. If `.ai/idea.md` already has content, refine it
   with the human rather than overwriting. `.ai/idea.md` is a working
   scratchpad; it is promoted into a change id at gate G0, when
   `/aeos:propose <change-id>` creates `openspec/changes/<change-id>/`.
3. Produce `.ai/idea.md` covering: problem, users, outcomes, constraints,
   success metrics, open questions.
4. Finish by telling the human: review `.ai/idea.md` and record gate **G0**
   using `aeos/templates/gate-record.template.md` →
   `.ai/reviews/<change-id>-g0.md`. Next: `/aeos:propose <change-id>`.
