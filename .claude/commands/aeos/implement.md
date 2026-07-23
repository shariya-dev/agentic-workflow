---
description: "AEOS phase 50 — brief a parallel implementation agent for one task"
---

Run AEOS phase **50-implementation** for: $ARGUMENTS
(expected: `<change-id> <task-id>`, e.g. `add-invoicing T-001`)

1. **Gate check:** verify `.ai/reviews/<change-id>-g2.md` exists and its
   `Decision` is `APPROVED` or `APPROVED-WITH-CONDITIONS`. If missing or
   `REJECTED`, STOP — no parallel agent runs before G2.
2. Read `aeos/prompts/50-implementation.md`. This is the per-agent briefing.
3. Assemble the **context-isolated brief** for the given task — the agent
   receives ONLY these six things, nothing else:
   - Golden Module — `.ai/foundation/golden-module.md`
   - Engineering Guide — `.ai/foundation/engineering-guide.md`
   - Architecture — `.ai/foundation/architecture.md` + `openspec/changes/<change-id>/design.md`
   - Contracts — `.ai/foundation/contracts.md` + any `.ai/contracts/<change-id>/contracts.md` delta
   - Handover — the module handover named in the task frontmatter
   - Task — `openspec/changes/<change-id>/tasks/<task-id>.md`
4. The agent builds one branch, staying inside its module scope, imitating the
   Golden Module, building against frozen contracts. Done = Definition of Done
   checked AND the verification command passes.
5. Finish by telling the human: the branch enters `/aeos:report` (testing) and
   `/aeos:review <change-id> code-review`; merge only on PASS. Wave N+1 starts
   only after wave N merges.

Note: in a Conductor-style setup, run one workspace per task and paste this
brief; `/aeos:implement` is the single-session equivalent.
