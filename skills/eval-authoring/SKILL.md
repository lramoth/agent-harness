---
name: eval-authoring
description: Use when writing an evaluation specification or performing an evaluation of implemented work.
---

# Eval Authoring

Non-negotiable rules:

- Evals derive from the spec, never the implementation.
- Test both success AND failure scenarios.
- Evaluation runs in fresh context, independent of implementation.
- No live external calls unless the spec explicitly requires them — use
  mocks, fixtures, or controlled test inputs.
- Results must describe observable behavior and never mention
  implementation identifiers or test mechanics (class names, function
  names, file paths, return values, internal algorithms).

Start from the template at `~/Projects/harness/templates/eval.template.md`.

Full evaluation lifecycle rules:
`~/Projects/harness/docs/development_workflow.md`.
