---
description: "AEOS phase 10 — domain discovery & data modeling"
---

Run AEOS phase **10-domain** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/proposal.md` exists.
   If not, STOP — run `/aeos:requirements` first.
2. Read `aeos/prompts/10-domain.md` and follow it exactly, using
   `aeos/guide/ddd-rules.md` and `aeos/templates/domain-model.template.md`.
3. Produce `.ai/domain/<change-id>/domain-model.md`: bounded contexts, actors,
   business rules, workflows, then entities/aggregates/value objects/schema/
   state transitions/validation, plus an event-storming section (events,
   commands, policies).
4. Finish by telling the human: approve the domain model, then
   `/aeos:architecture <change-id>`.
