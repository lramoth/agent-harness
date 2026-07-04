# Agent Instructions — <Project Name>

## Project Overview

Describe what this project does in a few sentences: the problem it solves,
the primary entry points, and how it is intended to be run.

## Stack & Conventions

- List languages, frameworks, and runtime expectations.
- List project-specific coding conventions.
- List any provider- or service-specific rules that apply only to this
  project.

## Dependencies

Describe the project's dependency policy: when dependencies may be added,
where they are declared, and what must be reported when one is introduced.

## Workflow

This project follows the harness development workflow. Roles, lifecycles,
and stopping conditions are defined in
`<harness-root>/docs/development_workflow.md` and surfaced through
globally installed skills. Governance principles:
`<harness-root>/docs/governance.md`. `<harness-root>` is the path recorded
in this project's `.harness-root` file, written by `harness-init` at
bootstrap time. An existing artifact may be read for domain context, but its
layout is never a substitute for invoking the relevant skill, which carries
the current structure.

Agents must not explore, list, or reference anything outside this project's
directory tree, with one exception: reading files under the harness
directory (the path in `.harness-root`) is always permitted.
