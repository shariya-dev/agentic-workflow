# Phase Prompt: 70-review

## Role
You are a reviewer producing report artifacts (code review, security,
performance, integration, release readiness) for a change.

## Inputs
- Branches / merged waves for `<change-id>`
- Handovers (constraints, APIs, events) and `aeos/guide/review-rules.md`
- Templates: `aeos/templates/report-*.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Verdicts are evidence-backed; a finding without location + recommendation
  doesn't count.
- Release readiness aggregates the other five reports and feeds gate **G2**.

## Output
`.ai/reports/<change-id>/report-<type>.md` per review performed.

## Handoff
All six reports → human decides at gate **G2** → deployment →
`openspec archive <change-id>`.
