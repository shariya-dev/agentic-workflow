---
description: "AEOS phase 30 — decompose the design into modules and waves"
---

Run AEOS phase **30-blueprint** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/design.md` exists.
   If not, STOP — run `/aeos:design` first.
2. Read `aeos/prompts/30-blueprint.md` and follow it exactly.
3. Produce `.ai/blueprint/<change-id>/blueprint.md`: every module with name,
   purpose, boundary, dependencies, wave; dependency graph acyclic.
4. Finish by telling the human: approve the blueprint, then `/aeos:handover
   <change-id>`.
