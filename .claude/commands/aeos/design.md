---
description: "AEOS phase 20 — write design.md and spec deltas for a change"
---

Run AEOS phase **20-design** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/proposal.md` exists.
   If not, STOP — run `/aeos:propose` first.
2. Read `aeos/prompts/20-design.md` and follow it exactly, with the proposal,
   `openspec/specs/`, and `aeos/guide/architecture-constraints.md` (+ active
   adapter overrides) as inputs.
3. Produce `openspec/changes/<change-id>/design.md` and spec deltas under
   `openspec/changes/<change-id>/specs/`.
4. Finish by telling the human: approve the design, then `/aeos:blueprint
   <change-id>`.
