---
artifact: engineering-guide
phase: 25-guardrails
owner: ai
inputs: ["openspec/changes/<change-id>/design.md", "aeos/guide/", "active adapter guide-overrides.md"]
outputs: [".ai/engineering-guide/<change-id>.md"]
purpose: Pin, for this change, the standards every module must follow — by reference to the static guide plus change-specific additions.
validation: All 8 guide areas referenced; adapter named; change-specific slots either filled or explicitly marked TODO. Does not restate the static guide.
---

# Engineering Guide (pinned): <change-id>

> This pins the standards for this change. Source of truth for the 8 areas is the
> static `aeos/guide/` plus the active adapter. Do not duplicate it here — pin
> and extend only.

- **Framework adapter:** <e.g. laravel>
- **Applicable guide files:** `aeos/guide/*` (all) + adapter `guide-overrides.md`

## Standards by reference
| Area | Source | Change-specific notes |
|------|--------|-----------------------|
| Coding standards | `aeos/guide/coding-standards.md` | |
| Folder conventions | `aeos/guide/folder-conventions.md` | |
| Naming conventions | `aeos/guide/naming.md` | |
| Architectural constraints | `aeos/guide/architecture-constraints.md` | |
| DDD rules | `aeos/guide/ddd-rules.md` | |
| SOLID expectations | `aeos/guide/solid.md` | |
| Testing rules | `aeos/guide/testing-rules.md` | |
| Review rules | `aeos/guide/review-rules.md` | |

## Change-specific skeleton
<!-- Folder structure for the new modules, base abstractions, shared libraries,
     templates. Fill or mark TODO — establish the structure, not every detail. -->
