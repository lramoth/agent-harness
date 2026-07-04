---
name: architecture
description: Use when creating architecture.md for a new project, or when a feature has changed the application's structure and architecture.md needs to be updated to reflect the current state.
---

# Architecture

Non-negotiable rules:

- `architecture.md` describes the application's current structure only —
  never a history of decisions or a changelog of past features.
- Update it, don't append to it: when a feature changes the structure it
  describes, edit the affected section in place. Superseded content is
  removed, not marked as old.
- It never duplicates spec, eval, or Work File contents — those record
  history and rationale; `architecture.md` records what is true now.
- Every completed feature that changes the application's structure must be
  reflected here before the Work File is marked complete.

Start from the template at `<harness-root>/templates/architecture.template.md`,
where `<harness-root>` is the path recorded in this project's
`.harness-root` file (or the harness repo root itself, if working inside the
harness repo).

Full workflow lifecycle rules:
`<harness-root>/docs/development_workflow.md`.
