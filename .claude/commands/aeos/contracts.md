---
description: "AEOS phase 35 — freeze the shared contracts"
---

Run AEOS phase **35-contracts** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/golden/<change-id>/golden-module.md` exists.
   If not, STOP — run `/aeos:golden` first.
2. Read `aeos/prompts/35-contracts.md` and follow it exactly, using the Golden
   Module, the design + spec deltas, the domain model, and
   `aeos/templates/contracts.template.md`.
3. Produce `.ai/contracts/<change-id>/contracts.md` — the frozen shared-interface
   set (APIs, DTOs, events, interfaces, database contracts, message formats),
   marked FROZEN with a version/date and consistent with the spec deltas.
4. Finish by telling the human: next is `/aeos:handover <change-id>`. Once
   frozen, no agent changes a contract independently.
