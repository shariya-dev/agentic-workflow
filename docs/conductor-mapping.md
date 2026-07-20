# Orchestrator Contract & Conductor Mapping

Stage 2 is defined against an abstract **Orchestrator Contract** so the
engineering stage never depends on one tool. Conductor is the first adapter
(`aeos/adapters/orchestrators/conductor/`).

## Orchestrator Contract

Any orchestrator MUST satisfy:

- **Inputs:** approved G1 gate record (`.ai/reviews/<id>-g1.md`); task files
  (`openspec/changes/<id>/tasks/`); handovers (`.ai/handovers/<id>/`);
  engineering guide + active framework adapter.
- **Outputs:** one reviewed branch per task, merged per wave.
- **Spawning:** one agent per task. Briefing = task file + its module handover
  + `aeos/prompts/60-implementation.md` (which loads the engineering guide).
- **Waves:** topological sort of task `depends_on`; wave N+1 starts only after
  wave N review passes.
- **Isolation:** one git worktree per agent; the task's module scope and Out of
  Scope section are hard boundaries.
- **Review flow:** every branch gets a code review report before merge.

## Where Conductor Begins

Conductor begins **only after G1 is recorded**. Nothing in Stage 1 involves it.

## Conductor Mapping

See `aeos/adapters/orchestrators/conductor/README.md` for the concrete mapping
(one workspace per task, briefing convention, `conductor.json` setup scripts).

## Swapping Orchestrators

Claude Code subagents, CI-driven agents, or any future tool can replace
Conductor by adding an adapter under `aeos/adapters/orchestrators/` that
documents how it satisfies this contract. Stage 1 artifacts do not change.
