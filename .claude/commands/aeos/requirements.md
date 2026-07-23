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
   stories, acceptance criteria, edge cases, impact). State the **Change-Type**
   (matching the G0 record) and, for any type other than `new-system`, an
   **Impact Analysis** of affected modules / foundation contracts / handovers.
   Run `openspec validate <change-id>` if the CLI is installed.
4. Finish by telling the human the phase path for this Change-Type
   (`aeos/workflows/change-types.md`) and the next command:
   - `new-system` → `/aeos:domain <change-id>`
   - `new-module` → `/aeos:domain <change-id>` (domain delta)
   - `module-change` → `/aeos:handover <change-id>` (reuse foundation; ADR first only if a real decision)
   - `patch` → `/aeos:tasks <change-id>` (then implement; foundation reused wholesale)
