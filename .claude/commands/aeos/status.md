---
description: "Show where every AEOS change sits in the lifecycle"
---

Report AEOS lifecycle status. For each change id found in `openspec/changes/`
(and any `.ai/` artifacts without a change folder yet):

1. Check which artifacts exist: idea (`.ai/idea.md`), proposal, design,
   blueprint (`.ai/blueprint/<id>/`), handovers (`.ai/handovers/<id>/`), tasks,
   reports (`.ai/reports/<id>/`).
2. Check which gate records exist in `.ai/reviews/` and their Decision lines.
3. Print a table: change id · furthest completed phase · last passed gate ·
   next action (the exact `/aeos:*` command or gate to record).
4. Flag inconsistencies: artifacts present without their preceding gate record,
   or gate records referencing missing artifacts.
