---
description: "AEOS phase 15 — architecture design + technology freeze"
---

Run AEOS phase **15-architecture** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/domain/<change-id>/domain-model.md` exists.
   If not, STOP — run `/aeos:domain` first.
2. Read `aeos/prompts/15-architecture.md` and follow it exactly, with the PRD,
   the domain model, `openspec/specs/`, and
   `aeos/guide/architecture-constraints.md` (+ active adapter overrides) as
   inputs.
3. Produce `openspec/changes/<change-id>/design.md` and spec deltas under
   `openspec/changes/<change-id>/specs/`, including the module boundary map. On a
   `new-system` change (or when `.ai/foundation/architecture.md` is missing),
   also record the base architecture (style, folder conventions, communication
   rules, frozen tech stack) to `.ai/foundation/architecture.md`. On later
   change types, reuse the foundation and describe only the delta in `design.md`.
   See `aeos/workflows/change-types.md`.
4. Finish by telling the human: approve the architecture, then `/aeos:adr
   <change-id>`.
