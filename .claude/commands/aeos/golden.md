---
description: "AEOS phase 30 — build the Golden Module (reference implementation)"
---

Run AEOS phase **30-golden-module** for change id: $ARGUMENTS

1. **Foundation check:** if the Change-Type is not `new-system` **and**
   `.ai/foundation/golden-module.md` already exists, STOP — the Golden Module is
   built once and reused. Tell the human to skip to `/aeos:contracts` (or
   `/aeos:handover`). See `aeos/workflows/change-types.md`.
2. **Gate check:** verify `.ai/reviews/<change-id>-g1.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS`. If missing or
   `REJECTED`, STOP — no code is written before G1.
3. Read `aeos/prompts/30-golden-module.md` and follow it exactly, using the
   design, the engineering guide, the domain model, and
   `aeos/templates/golden-module.template.md`.
4. Produce (a) one complete reference module with passing tests on a branch, and
   (b) `.ai/foundation/golden-module.md` — a written tour of the module and the
   patterns to copy (project-level foundation).
5. Finish by telling the human: next is `/aeos:contracts <change-id>` (freeze
   the shared interfaces the Golden Module proved).
