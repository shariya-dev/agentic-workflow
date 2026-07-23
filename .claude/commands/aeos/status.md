---
description: "Show where every AEOS change sits in the lifecycle"
---

Report AEOS lifecycle status. For each change id found in `openspec/changes/`
(and any `.ai/` artifacts without a change folder yet):

1. Check which artifacts exist, in order:
   - Stage 1: idea (`.ai/idea.md`), PRD (`openspec/changes/<id>/proposal.md`),
     domain model (`.ai/domain/<id>/`), architecture
     (`openspec/changes/<id>/design.md`), ADRs (`.ai/adr/<id>/`), engineering
     guide (`.ai/engineering-guide/<id>.md`).
   - Stage 2: golden module (`.ai/golden/<id>/`), contracts
     (`.ai/contracts/<id>/`), handovers (`.ai/handovers/<id>/`), blueprint +
     tasks (`.ai/blueprint/<id>/`, `openspec/changes/<id>/tasks/`).
   - Stage 3: reports (`.ai/reports/<id>/`) incl. documentation.
2. Check which gate records exist in `.ai/reviews/` (`-g0`,`-g1`,`-g2`,`-g3`)
   and their Decision lines.
3. Print a table: change id · furthest completed phase · last passed gate ·
   next action (the exact `/aeos:*` command or gate to record).
4. Flag inconsistencies: artifacts present without their preceding gate record,
   a Stage-2/3 artifact without its authorizing gate, or a gate record
   referencing missing artifacts.
