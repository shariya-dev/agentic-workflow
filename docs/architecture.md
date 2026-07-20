# AEOS Architecture

AEOS separates three lifecycles by *rate and direction of change*:

| Home | Role | Mutability |
|------|------|-----------|
| `aeos/` | **The System** — prompts, templates, workflows, guide, adapters | Immutable per-project; upgrade = sync from upstream AEOS |
| `openspec/` | **The Spec Lifecycle** — OpenSpec CLI territory (`specs/` = current truth, `changes/<id>/` = active change) | Managed by `openspec` tooling |
| `.ai/` | **The Workspace** — idea, blueprint, handovers, reviews, reports | Mutable, born per-project |

AEOS never duplicates what OpenSpec owns; it wraps the spec lifecycle with
human gates and richer artifacts, cross-linked by a shared `<change-id>`.

## Artifact Contract

Every artifact template (`aeos/templates/`) opens with machine-readable
frontmatter: `artifact, phase, owner, inputs, outputs, purpose, validation`.
An artifact is valid only when its validation criteria hold.

## Artifact Dependency Graph

```
idea → proposal → design → blueprint → handovers → tasks → [G1] → code
                     ↘ spec deltas ─────────────────────────↗ (agent context)
code → review + test + integration + security reports → [G2] → deploy → archive
```

Per-phase owner/inputs/outputs/validation: `aeos/workflows/phases.md`.
Gate definitions: `aeos/workflows/gates.md`.

## Extensibility

Stack and tool specifics live only in `aeos/adapters/` (contract:
`aeos/adapters/_contract.md`). Framework adapters (Laravel first; .NET,
NestJS, Spring Boot, Django, FastAPI later) fill `<!-- adapter-override -->`
markers in `aeos/guide/` and supply verification commands. Orchestrator
adapters (Conductor first) bind Stage 2 to a concrete tool. The lifecycle is
identical regardless of adapter.
