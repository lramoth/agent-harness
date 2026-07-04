---
name: spec-authoring
description: Use when writing or reviewing a behavioral specification for any feature or component.
---

# Spec Authoring

Non-negotiable rules:

- Specs describe observable behavior only — what a user, caller, operator,
  evaluator, or artifact reader can see.
- Never prescribe file names, class names, function names, data structures,
  algorithms, library choices, or internal helpers unless they are
  themselves observable public requirements.
- The spec is the implementation contract: it defines inputs, outputs,
  failure handling, acceptance criteria, constraints, and out-of-scope work.

Start from the template at `<harness-root>/templates/spec.template.md`, where
`<harness-root>` is the path recorded in this project's `.harness-root` file
(or the harness repo root itself, if working inside the harness repo).

Full specification lifecycle rules:
`<harness-root>/docs/development_workflow.md`.
