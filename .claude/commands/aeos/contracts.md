---
description: "AEOS phase 35 — freeze the shared contracts"
---

Run AEOS phase **35-contracts** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/foundation/golden-module.md` exists (the Golden
   Module, built this change or on a prior `new-system` change). If not, STOP —
   run `/aeos:golden` first.
2. **Change-type routing** (`aeos/workflows/change-types.md`):
   - `new-system` (or `.ai/foundation/contracts.md` missing) → write base
     contracts to `.ai/foundation/contracts.md`.
   - `new-module` → write only the delta to `.ai/contracts/<change-id>/contracts.md`.
   - `patch` / `module-change` with no shared-interface change → SKIP; tell the
     human contracts are unchanged, go to `/aeos:handover`.
3. Read `aeos/prompts/35-contracts.md` and follow it exactly, using the Golden
   Module, the design + spec deltas, the domain model, and
   `aeos/templates/contracts.template.md`.
4. Produce the contracts (base or delta per step 2) — APIs, DTOs, events,
   interfaces, database contracts, message formats — marked FROZEN with a
   version/date and consistent with the spec deltas.
5. Finish by telling the human: next is `/aeos:handover <change-id>`. Once
   frozen, no agent changes a contract independently.
