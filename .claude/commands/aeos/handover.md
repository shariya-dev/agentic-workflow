---
description: "AEOS phase 40 — write one handover document per module"
---

Run AEOS phase **40-handover** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/contracts/<change-id>/contracts.md` exists
   (contracts frozen). If not, STOP — run `/aeos:contracts` first.
2. Read `aeos/prompts/40-handover.md` and follow it exactly, using the design,
   domain model, frozen contracts, the Golden Module, the engineering guide, and
   `aeos/templates/handover.template.md` for every module.
3. Produce `.ai/handovers/<change-id>/<module>.handover.md` for each module —
   every section filled; provider/consumer APIs and events match pairwise and
   match the frozen contracts; explicit Do's and Don'ts and Out-of-Scope.
4. Finish by telling the human: next is `/aeos:tasks <change-id>`.
