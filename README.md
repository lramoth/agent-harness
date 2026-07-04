# agent-harness

A reusable, tool-agnostic AI-development methodology, kept as plain markdown
in one repository and consumed by every project.

## What this is

The harness is the *framework*: the autonomous feature development workflow
(Director, Planner Agent, Implementation Agent, Evaluation Agent), its
governance principles, the artifact templates (specs, evals, Work Files),
and the skills that surface them. Individual projects are *instances*: each
project keeps only its own content — stack, conventions, dependencies,
provider-specific rules — in its `AGENTS.md`, and points at the harness for
everything methodological.

This split means the methodology evolves in one place. Projects never
restate roles, lifecycles, or stopping conditions; they reference
`docs/development_workflow.md` and `docs/governance.md` here.

## Layout

- `docs/` — the source-of-truth methodology documents.
- `skills/` — short, routing-oriented skills (one directory per skill, each
  with a `SKILL.md`). Skills carry the non-negotiable rules inline and point
  to `docs/` and `templates/` for depth.
- `templates/` — starting points for specs, evals, Work Files, and new
  projects' `AGENTS.md` / `CLAUDE.md`.
- `bin/harness-init` — project bootstrap script.

## Skill distribution

Skills are distributed by symlinking each skill directory into the
tool-specific global skill locations. After adding a skill, run:

```sh
/path/to/harness/bin/harness-sync
```

It links every skill under `skills/` into `~/.claude/skills` and
`~/.codex/skills`, skipping anything already present. It is idempotent and
safe to run anytime.

Because they are symlinks, editing a skill in the harness updates it for
both Claude Code and Codex immediately. The skill files themselves stay
plain markdown so any tool that reads a `SKILL.md` can consume them.

## Bootstrapping a new project

> **Before you start:** run `/path/to/harness/bin/harness-sync` at least once
> so the harness skills are symlinked into your tool's global skills
> directory. Without this step, skills like `work-file` and `spec-authoring`
> won't be available in the new project.

From the new project's root directory, run:

```sh
/path/to/harness/bin/harness-init
```

This creates:

- `AGENTS.md` and `CLAUDE.md` — copied from the harness templates, with the
  harness version (from `git describe`) stamped at the bottom of `AGENTS.md`
- `architecture.md` — copied from the harness template; describes the
  application's current structure and is kept up to date by the
  `architecture` skill as features land
- `specs/`, `evals/`, `work/` — empty directories for the workflow's
  artifacts. Work Files are created per feature (one file per feature, named
  after the feature) by the `work-file` skill — none are pre-seeded.
- `.harness-root` — records the harness's location so skills and docs can
  find it regardless of where the harness is cloned

`harness-init` refuses to overwrite any file that already exists.

**Next steps:**

1. Fill in the project-specific sections of `AGENTS.md`.
2. You're ready to work — see the example below.

## Example: requesting a feature

With the project bootstrapped and skills synced, start by asking as the
Director:

> As Director, create a Work File for a new feature: a command-line tool
> `wordcount` that reads text from stdin and prints the number of words to
> stdout.

This produces a Work File under `work/` with just the goal and intent
filled in — no implementation detail, per the Director's role in
`docs/development_workflow.md`. It's deliberately small so the full loop
below runs in seconds.

Then hand it off:

> Act as Planner Agent and carry `work/<feature-name>.md` through to
> completion — write the spec, coordinate implementation, write the eval,
> coordinate evaluation, update `architecture.md` to reflect the current
> state, and record the results.

This drives the full loop: specification, implementation, evaluation, an
architecture update, and a final summary recorded back in the Work File for
the Director to accept.
