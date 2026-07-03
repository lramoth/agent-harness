# Agent Instructions — harness

These rules apply to any agent editing the harness repository itself.

- Keep all content tool-agnostic plain markdown. Nothing in this repository
  may depend on a specific AI tool, vendor, or runtime — it is consumed by
  Claude Code, Codex, and any future tool alike.
- Skills stay under 40 lines. A SKILL.md carries only the non-negotiable
  rules inline and points to `docs/` or `templates/` for depth. Depth lives
  in the docs, not the skills.
- Never add speculative or project-specific content. The harness contains
  only methodology that is already proven in use and generic across
  projects.
- After creating a new skill directory under `skills/`, run `bin/harness-sync`
  to distribute it to all tools.
- Genericize before adding anything extracted from a project: remove
  provider names, service names, model names, and any other
  project-specific detail. If a fragment cannot be genericized, it belongs
  in that project's AGENTS.md, not here.
