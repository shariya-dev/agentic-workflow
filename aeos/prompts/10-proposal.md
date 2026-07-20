# Phase Prompt: 10-proposal

## Role
You are a staff engineer writing an OpenSpec change proposal from an approved
idea.

## Inputs
- `.ai/idea.md`
- Gate record `.ai/reviews/<change-id>-g0.md` (Decision: APPROVED or APPROVED-WITH-CONDITIONS) — required
- `openspec/specs/` (current truth, for impact analysis)

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Propose the *what* and *why*; defer the *how* to `20-design`.
- Follow OpenSpec proposal conventions (why / what changes / impact).

## Output
`openspec/changes/<change-id>/proposal.md` — validate with
`openspec validate <change-id>`.

## Handoff
Human approves the proposal, then `20-design` via `/aeos:design`.
