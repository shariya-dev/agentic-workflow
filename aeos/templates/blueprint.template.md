---
artifact: blueprint
phase: 45-tasks
owner: ai
inputs: [".ai/handovers/<change-id>/", "openspec/changes/<change-id>/design.md"]
outputs: [".ai/blueprint/<change-id>/blueprint.md"]
purpose: The execution plan — what runs in which wave, in what order — that the orchestrator reads.
validation: Every module placed in a wave; dependency graph acyclic; Golden Module is wave 0; shared components and risks listed.
---

# Implementation Blueprint: <change-id>

## Module Order & Dependency Graph
<!-- List modules and what each depends on. The graph must be acyclic. -->

## Parallel Waves
<!-- Modules that can be built simultaneously share a wave. -->

```
Wave 0 — <golden module>        (reference, already built)
Wave 1 — <module A>, <module B> (no dependencies between them)
Wave 2 — <module C>             (depends on wave 1)
Wave 3 — <module D>
```

## Shared Components
<!-- Cross-cutting pieces (auth, base classes, shared libs) and who owns them. -->

## Risks
<!-- Integration risks, sequencing risks, contract pressure points. -->

## Orchestration Notes
<!-- One workspace per task; wave N+1 starts only after wave N merges. -->
