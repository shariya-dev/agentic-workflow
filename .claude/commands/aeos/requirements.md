---
description: "AEOS phase 05 — requirement analysis: write the PRD proposal"
---

Run AEOS phase **05-requirements** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g0.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS`. If missing or
   `REJECTED`, STOP and tell the human gate G0 is missing.
2. Read `aeos/prompts/05-requirements.md` and follow it exactly, with
   `.ai/idea.md` and `openspec/specs/` as inputs and
   `aeos/templates/prd.template.md` for structure.
3. Produce `openspec/changes/<change-id>/proposal.md` — a full PRD that is also
   an OpenSpec-valid proposal (functional/non-functional requirements, user
   stories, acceptance criteria, edge cases, impact). Run
   `openspec validate <change-id>` if the CLI is installed.
4. Finish by telling the human: approve the PRD, then `/aeos:domain
   <change-id>`.
