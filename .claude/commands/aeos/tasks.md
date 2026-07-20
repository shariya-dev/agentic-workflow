---
description: "AEOS phase 50 — slice handovers into atomic tasks for parallel agents"
---

Run AEOS phase **50-tasks** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/handovers/<change-id>/` contains at least one
   `*.handover.md`. If not, STOP — run `/aeos:handover` first.
2. Read `aeos/prompts/50-tasks.md` and follow it exactly, using
   `aeos/templates/task.template.md` per task. Verification commands come from
   the active framework adapter's `verification.md`.
3. Produce `openspec/changes/<change-id>/tasks.md` (index) plus one file per
   task under `openspec/changes/<change-id>/tasks/`; `depends_on` acyclic,
   waves consistent with the blueprint.
4. Finish by telling the human: review the full Stage-1 set and record gate
   **G1** → `.ai/reviews/<change-id>-g1.md`. After G1, hand off to the
   orchestrator (see `docs/conductor-mapping.md`).
