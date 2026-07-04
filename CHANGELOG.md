# Changelog

All notable changes to the harness are recorded here, one section per tag.
`harness-check` and `harness-upgrade` read this file to show what changed
between a project's stamped version and the current harness.

Cut a new tag whenever the harness reaches a checkpoint other projects should
pick up, and add the matching section here in the same commit — including a
migration note whenever a change requires action in already-bootstrapped
projects (e.g. "this version added `architecture.md` — create one via the
`architecture` skill").

## [Unreleased]

- Added `harness-attach` for reconnecting an already-bootstrapped project
  (fresh clone, second machine, CI) without overwriting existing files.
- `harness-check` now detects dangling skill symlinks (skills removed
  upstream) and exits nonzero on any drift instead of always exiting 0.
- Added `harness-sync --repair` to prune dangling skill symlinks;
  `harness-upgrade` now calls it instead of plain `harness-sync`.
- Added CI: shellcheck plus an end-to-end smoke test (`test/smoke-test.sh`).
- Added `LICENSE` (MIT).
- Seeded `templates/work-file.template.md` with commented-out Planner
  sections so per-feature Work Files converge on one structure.
- Added this `CHANGELOG.md` and the tag-plus-changelog discipline it
  documents.

## [v0.1.0] - 2026-07-03

- Bootstrapped the harness: `docs/`, `skills/`, `templates/`, and
  `bin/harness-init` extracted from infoPipeline as a reusable,
  tool-agnostic methodology.
