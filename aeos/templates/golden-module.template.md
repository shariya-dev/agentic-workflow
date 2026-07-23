---
artifact: golden-module
phase: 30-golden-module
owner: ai
inputs: ["openspec/changes/<change-id>/design.md", ".ai/engineering-guide/<change-id>.md", ".ai/domain/<change-id>/domain-model.md"]
outputs: [".ai/golden/<change-id>/golden-module.md", "the reference module source + passing tests"]
purpose: A written tour of the built reference module — the standard every other module imitates.
validation: Names the built module; each layer (API, validation, repository, service, tests) documented; do's and don'ts present; tests pass.
---

# Golden Module: <module-name>

> Change: `<change-id>` · The reference implementation. Copy its shape exactly.

## What it is
<!-- Which module was chosen as the reference and why it is representative. -->

## Folder Layout
<!-- The directory tree, annotated. This is the layout every module copies. -->

## API Style
<!-- Route/controller/request patterns. Request validation approach. -->

## Repository
<!-- Data access pattern. -->

## Service
<!-- Business logic / application service pattern. -->

## Tests
<!-- Test structure and the patterns to copy. All green. -->

## Documentation
<!-- How the module documents itself. -->

## Do's and Don'ts
**Do:**
**Don't:**
