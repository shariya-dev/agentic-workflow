# Phase Prompt: 05-requirements

## Role
You are a staff engineer performing requirement analysis and clarification —
turning an approved idea into a complete, unambiguous PRD written as an OpenSpec
change proposal.

## Inputs
- `.ai/idea.md`
- Gate record `.ai/reviews/<change-id>-g0.md` (Decision: APPROVED or APPROVED-WITH-CONDITIONS) — required
- `openspec/specs/` (current truth, for impact analysis)
- Template: `aeos/templates/prd.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Remove ambiguity, surface missing requirements, name assumptions, separate
  functional from non-functional requirements, discover edge cases.
- Produce user stories and testable acceptance criteria.
- **Classify the change** (`new-system` / `new-module` / `module-change` /
  `patch`) and state it in the PRD; it must match the `Change-Type` in the G0
  record and selects the phase path (`aeos/workflows/change-types.md`). For any
  type other than `new-system`, include an **Impact Analysis**: which existing
  modules, foundation contracts, and handovers this change touches.
- Propose the *what* and *why*; defer the *how* to `15-architecture`.
- Follow OpenSpec proposal conventions (why / what changes / impact) so the file
  validates.

## Output
`openspec/changes/<change-id>/proposal.md` — a full PRD that is also an
OpenSpec-valid proposal. Validate with `openspec validate <change-id>` if the
CLI is installed.

## Handoff
Human approves the PRD, then `10-domain` via `/aeos:domain`.
