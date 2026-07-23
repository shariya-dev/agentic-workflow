---
description: "AEOS phase 40 — write one handover document per module"
---

Run AEOS phase **40-handover** for change id: $ARGUMENTS

1. **Input check:** verify frozen contracts exist — either
   `.ai/contracts/<change-id>/contracts.md` (this change's delta) or
   `.ai/foundation/contracts.md` (reused base). If neither, STOP — run
   `/aeos:contracts` first.
2. Read `aeos/prompts/40-handover.md` and follow it exactly, using the design,
   domain model, the frozen contracts (per-change delta layered on the
   foundation), the foundation Golden Module, the foundation engineering guide,
   and `aeos/templates/handover.template.md`. For a `module-change`, update the
   affected module's existing handover rather than writing new ones.
3. Produce `.ai/handovers/<change-id>/<module>.handover.md` for each module —
   every section filled; provider/consumer APIs and events match pairwise and
   match the frozen contracts; explicit Do's and Don'ts and Out-of-Scope.
4. Finish by telling the human: next is `/aeos:tasks <change-id>`.
