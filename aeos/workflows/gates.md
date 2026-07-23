# AEOS Human Approval Gates

A gate is passed only when a record exists at `.ai/reviews/<change-id>-g<n>.md`
(from `aeos/templates/gate-record.template.md`) whose `Decision` is `APPROVED`
or `APPROVED-WITH-CONDITIONS` (a `REJECTED` record does not pass).
Approval is a version-controlled artifact, not a verbal event.

There are four gates, positioned around the two irreversible commitments:
starting to write code (the Golden Module) and the parallel explosion.

## G0 — Idea Gate

- **Reviews:** `.ai/idea.md` — is this worth building?
- **Decision owner:** Product owner
- **Blocks:** Requirement analysis (`/aeos:requirements` refuses without it)

## G1 — Design Gate

- **Reviews:** PRD + domain model + architecture + ADRs + engineering guide —
  the whole design, as a set. No application code exists yet.
- **Decision owner:** Architect / tech lead
- **Blocks:** The Golden Module (`/aeos:golden` refuses without it). This is the
  last point before any code is written.

## G2 — Foundation Gate

- **Reviews:** the Golden Module (is this the standard we want every module to
  copy?), the frozen contracts, the handovers, the blueprint, and the tasks.
- **Decision owner:** Tech lead
- **Blocks:** ALL parallel agent spawning (`/aeos:implement` refuses without it).
  This is the framework's most important gate — the moment before the design is
  multiplied across every module.

## G3 — Release Gate

- **Reviews:** all reports in `.ai/reports/<id>/` (test coverage, code review,
  integration, security, performance, release readiness)
- **Decision owner:** Release owner
- **Blocks:** Documentation-handover, deployment, and `openspec archive`
- **Note:** in v1, G3 has no command-level deploy enforcement (there is no
  deploy command); the release owner enforces it by process. `/aeos:docs`
  checks for the G3 record.

## Conditional Approval

A gate record may carry `Decision: APPROVED-WITH-CONDITIONS` plus a Conditions
list. Conditions become tasks in the change and must close before the next gate.
