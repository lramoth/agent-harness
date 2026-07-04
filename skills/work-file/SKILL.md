---
name: work-file
description: Use when creating or updating a Work File — the durable per-feature record of requests, decisions, implementation and evaluation results.
---

# Work File

Non-negotiable rules:

- The Work File is the single durable record for a feature.
- Each feature gets its own file: `work/<kebab-case-feature-title>.md`. Never
  reuse or overwrite another feature's Work File, and never write to a
  generic name like `work/WORK_FILE.md`.
- It records paths to specs and evals; it never duplicates their contents.
- Per the workflow doc, it must record: the original request, Planner Agent
  decisions, specification path, implementation summary, observations,
  tests or checks run, assumptions, limitations, future work, evaluation
  path, evaluation result, final summary, and Director acceptance status.

Start from the template at
`<harness-root>/templates/work-file.template.md`, where `<harness-root>` is
the path recorded in this project's `.harness-root` file (or the harness
repo root itself, if working inside the harness repo).

Full Work File lifecycle rules:
`<harness-root>/docs/development_workflow.md`.
