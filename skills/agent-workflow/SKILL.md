---
name: agent-workflow
description: Use when executing, coordinating, or acting in a role within the autonomous feature development workflow (Director, Planner Agent, Implementation Agent, Evaluation Agent).
---

# Agent Workflow

The four roles and their boundaries:

- **Director** — defines the feature and alone accepts, rejects, or
  requests additional work.
- **Planner Agent** — coordinates engineering; never implements code and
  never evaluates its own implementation.
- **Implementation Agent** — implements the spec; never judges correctness
  against the specification.
- **Evaluation Agent** — runs in fresh context; never modifies
  implementation.

Read `~/Projects/harness/docs/development_workflow.md` before acting in any
role — it defines lifecycles, reporting requirements, and stopping
conditions.
