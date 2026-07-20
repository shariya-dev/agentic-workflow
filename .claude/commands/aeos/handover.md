---
description: "AEOS phase 40 — write one handover document per blueprint module"
---

Run AEOS phase **40-handover** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/blueprint/<change-id>/blueprint.md` exists.
   If not, STOP — run `/aeos:blueprint` first.
2. Read `aeos/prompts/40-handover.md` and follow it exactly, using
   `aeos/templates/handover.template.md` for every module.
3. Produce `.ai/handovers/<change-id>/<module>.handover.md` for each blueprint
   module — all 11 sections filled; provider/consumer APIs and events must
   match pairwise.
4. Finish by telling the human: next is `/aeos:tasks <change-id>`.
