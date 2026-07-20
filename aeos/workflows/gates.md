# AEOS Human Approval Gates

A gate is passed only when a record exists at `.ai/reviews/<change-id>-g<n>.md`
(from `aeos/templates/gate-record.template.md`) whose `Decision` is `APPROVED`
or `APPROVED-WITH-CONDITIONS` (a `REJECTED` record does not pass).
Approval is a version-controlled artifact, not a verbal event.

## G0 — Idea Gate

- **Reviews:** `.ai/idea.md` — is this worth speccing?
- **Decision owner:** Product owner
- **Blocks:** Proposal phase (`/aeos:propose` refuses without it)

## G1 — Engineering Gate

- **Reviews:** proposal + design + blueprint + handovers + tasks — scope and
  architecture as a whole
- **Decision owner:** Tech lead / architect
- **Blocks:** ALL Stage 2 agent spawning. No orchestrator run without it.

## G2 — Release Gate

- **Reviews:** all six reports in `.ai/reports/<id>/` (code review, security,
  performance, integration, test coverage, release readiness)
- **Decision owner:** Release owner
- **Blocks:** Deployment and `openspec archive`
- **Note:** in v1, G2 has no command-level enforcement (there is no deploy
  command); the release owner enforces it by process.

## Conditional Approval

A gate record may carry `Decision: APPROVED-WITH-CONDITIONS` plus a Conditions
list. Conditions become tasks in the change and must close before the next gate.
