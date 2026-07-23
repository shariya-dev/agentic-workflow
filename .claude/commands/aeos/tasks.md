---
description: "AEOS phase 45 — implementation blueprint (waves) + atomic task slices"
---

Run AEOS phase **45-tasks** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/handovers/<change-id>/` contains at least one
   `*.handover.md`. If not, STOP — run `/aeos:handover` first.
2. Read `aeos/prompts/45-tasks.md` and follow it exactly, using
   `aeos/templates/blueprint.template.md` for the wave plan and
   `aeos/templates/task.template.md` per task. Verification commands come from
   the active framework adapter's `verification.md`.
3. Produce:
   - `.ai/blueprint/<change-id>/blueprint.md` — module order, dependency graph,
     parallel waves (Golden Module is wave 0), shared components, risks.
   - `openspec/changes/<change-id>/tasks.md` (index) + one file per task under
     `openspec/changes/<change-id>/tasks/`; `depends_on` acyclic, waves
     consistent with the blueprint.
4. Finish by telling the human: review the foundation set (golden module,
   contracts, handovers, blueprint, tasks) and record gate **G2** →
   `.ai/reviews/<change-id>-g2.md`. After G2, spawn parallel agents via
   `/aeos:implement` (see `docs/conductor-mapping.md`).
