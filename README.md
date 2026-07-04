# harness

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

From the new project's root directory, run:

```sh
/path/to/harness/bin/harness-init
```

This copies `AGENTS.template.md` and `CLAUDE.template.md` into the current
directory as `AGENTS.md` and `CLAUDE.md`, creates the `specs/`, `evals/`, and
`work/` directories, copies `work-file.template.md` into `work/` as
`WORK_FILE.md`, stamps the harness version (from `git describe`) into that
Work File, writes a `.harness-root` file recording the harness's location so
skills and docs can find it regardless of where it's cloned, refuses to
overwrite existing files, and prints the next steps. Fill in the
project-specific sections of `AGENTS.md` and you are ready to work.
