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
- `bin/` — the commands below.
- `CHANGELOG.md` — one section per tag; see Staying current below.

## Commands

Run these as `/path/to/harness/bin/<command>`.

| Command | Purpose | Safe to re-run? |
| --- | --- | --- |
| `harness-sync` | Symlinks every skill under `skills/` into `~/.claude/skills` and `~/.codex/skills`, skipping anything already present. `harness-sync --repair` additionally prunes dangling symlinks that point into this harness (skills removed upstream) before relinking. | Yes — additive only; `--repair` only ever removes symlinks it recognizes as pointing into this harness. |
| `harness-init` | Bootstraps a new project: copies `AGENTS.md`, `CLAUDE.md`, `architecture.md` from templates, creates `specs/`, `evals/`, `work/`, writes `.harness-root`, and stamps the harness version at the bottom of `AGENTS.md`. | Yes — never overwrites, but errors out on a second run instead of no-op'ing (see `harness-attach`). |
| `harness-attach` | Reconnects an already-bootstrapped project (fresh clone, second machine, CI): writes `.harness-root` if missing and creates any of `specs/`, `evals/`, `work/` that are missing. | Yes — touches nothing that already exists. |
| `harness-check` | Reports whether the project's stamped harness version is behind, which harness skills aren't linked locally yet, and which linked skills are dangling (removed upstream). Makes no changes. Exits nonzero if anything is out of date, missing, or dangling. | Yes — read-only. |
| `harness-upgrade` | Runs `harness-sync --repair` to link new skills and prune dangling ones, then updates the project's stamped harness version to match. | Yes. |

Because skills are distributed as symlinks, editing a skill in the harness
updates it for both Claude Code and Codex immediately. The skill files
themselves stay plain markdown so any tool that reads a `SKILL.md` can
consume them.

## Bootstrapping a new project

> **Before you start:** run `harness-sync` at least once so the harness
> skills are symlinked into your tool's global skills directory. Without
> this step, skills like `work-file` and `spec-authoring` won't be available
> in the new project.

From the new project's root directory, run `harness-init` (see Commands
above for what it creates). Afterward, the project looks like:

```
project-root/
├── .gitignore
├── .harness-root       # gitignored — machine-specific harness location
├── AGENTS.md           # stamped with the harness version at the bottom
├── CLAUDE.md           # imports AGENTS.md
├── architecture.md
├── specs/              # empty — behavioral specifications land here
├── evals/              # empty — evaluation specifications land here
└── work/               # empty — one Work File per feature, via the work-file skill
```

**Next steps:**

1. Fill in the project-specific sections of `AGENTS.md`.
2. You're ready to work — see the example below.

## Reconnecting a project on a new clone or machine

`.harness-root` is gitignored (it's machine-specific), so a fresh clone, a
second machine, or a CI checkout of an already-bootstrapped project won't
have it — and `harness-init` will refuse to run again since `AGENTS.md` etc.
already exist. Run `harness-attach` instead (see Commands above).

## Example: requesting a feature

With the project bootstrapped and skills synced, open the project in Claude
Code or Codex (`harness-sync` links skills into both) and start by asking as
the Director:

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

## Staying current with the harness

Each `harness-init`'d project stamps the harness version it was bootstrapped
from at the bottom of `AGENTS.md`. As the harness moves on — new skills, a
changed `docs/development_workflow.md` — a project's stamp can fall behind.

From the project's root directory, run `harness-check` to see if it's
behind, then `harness-upgrade` to catch it up (see Commands above). Both
commands print the relevant `CHANGELOG.md` sections for any tag released
since the project's stamped version, including migration notes when a
change requires action in already-bootstrapped projects.

**Tag discipline:** cut a new annotated tag whenever the harness reaches a
checkpoint other projects should pick up, and add the matching
`## [vX.Y.Z] - date` section to `CHANGELOG.md` in the same commit. This is
what lets `harness-check`/`harness-upgrade` show a project what changed —
an untagged commit or a tag with no changelog section is invisible to them.
