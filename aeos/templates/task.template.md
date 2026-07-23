---
artifact: task
phase: 45-tasks
owner: ai
inputs: [".ai/handovers/<change-id>/<module>.handover.md"]
outputs: ["openspec/changes/<change-id>/tasks/<task-id>.md"]
purpose: One atomic, measurable, independently executable unit of work for one AI agent.
validation: Has objective, definition of done, verification command; touches only files inside its declared module scope; depends_on lists task ids only.
---

# Task: <task-id> — <short title>

```yaml
id: <task-id>            # e.g. T-003
change_id: <change-id>
module: <module-name>
handover: .ai/handovers/<change-id>/<module>.handover.md
depends_on: []           # task ids that must merge first
wave: 1                  # topological wave number
estimated_scope: S       # S / M / L
```

## Objective
<!-- One sentence. What exists when this task is done that didn't before. -->

## Context Files
<!-- Exact paths the agent should read before starting. -->

## Definition of Done
- [ ] <!-- observable, checkable outcomes only -->

## Verification Command
```bash
# exact command an agent runs to prove the task is done; from the adapter's verification conventions
```

## Out of Scope
<!-- What this task must NOT touch, to protect module isolation. -->
