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
`~/Projects/harness/docs/development_workflow.md` and surfaced through
globally installed skills. Governance principles:
`~/Projects/harness/docs/governance.md`.

Agents must not explore, list, or reference anything outside this project's
directory tree, with one exception: reading files under the harness directory
(`~/Projects/harness`) is always permitted.
