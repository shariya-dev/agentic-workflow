# Adapter Contract

An adapter binds the framework-agnostic AEOS lifecycle to a concrete tool or
stack. The lifecycle never names a stack outside `aeos/adapters/`. Two families:

## Framework Adapters (`frameworks/<name>/`)

Every framework adapter MUST provide:

| File | Purpose |
|------|---------|
| `README.md` | What the adapter covers, stack versions, how to activate it |
| `guide-overrides.md` | Content for every `<!-- adapter-override: ... -->` marker in `aeos/guide/` |
| `verification.md` | Exact commands tasks use in their Verification Command section (test, lint, static analysis) |

An adapter MAY add scaffold conventions (generators, starter layouts). It must
not alter phase order, artifacts, or gates.

## Orchestrator Adapters (`orchestrators/<name>/`)

Every orchestrator adapter MUST document how the tool satisfies the
Orchestrator Contract (`docs/conductor-mapping.md`):

- how agents are spawned (one per task) and briefed (task file + module
  handover + implementation prompt, which loads the engineering guide)
- how waves are executed in dependency order
- how module isolation is enforced (e.g. one git worktree per agent)
- how review flows before merge

## Activation

A project activates one framework adapter and one orchestrator adapter and
records the choice in its README. Multiple framework adapters may coexist in
`aeos/adapters/` — only the activated one applies.
