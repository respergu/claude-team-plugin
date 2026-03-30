# claude-team-plugin

Shared Claude Code plugin for the team. Centralizes reusable AI-assisted
development workflows so every repo gets the same capabilities.

## Plugin structure

This repo is both a **Claude Code plugin** and a **plugin marketplace**.

- `.claude-plugin/plugin.json` — plugin manifest (name, version, author)
- `.claude-plugin/marketplace.json` — marketplace catalog listing this plugin

When installed, Claude Code automatically discovers skills, hooks, and
settings from the plugin root:

- **Skills** — `skills/<name>/SKILL.md` (invoked as `/claude-team-plugin:<name>`)
- **Hooks** — `hooks/hooks.json` (fire automatically when plugin is enabled)
- **Settings** — `settings.json` (applied as defaults when plugin is enabled)

## Distribution

1. **Marketplace** (primary) — register with `/plugin marketplace add respergu/claude-team-plugin`, then install with `/plugin install claude-team-plugin@claude-team-marketplace`
2. **Install script** (CI fallback) — `install-skills.sh` copies skills into `.claude/skills/`
3. **GitHub Actions** — `action.yml` composite action for CI pipelines

## How to add a skill

1. Create `skills/<skill-name>/SKILL.md` with YAML frontmatter (see `docs/SKILL-SPEC.md`)
2. Skill name must be lowercase-kebab-case and match the directory name
3. Add any reference files under `skills/<skill-name>/references/`
4. Update `manifest.json` (or let CI regenerate it on release)
5. Add a CHANGELOG entry under `[Unreleased]`
6. Open a PR — CI will validate frontmatter, naming, and changelog

## Naming conventions

- Skill directories: `lowercase-kebab-case`
- Frontmatter `description` field is required
- No `fff-` prefix — that's reserved for project-specific local skills

## Key files

- `.claude-plugin/plugin.json` — plugin manifest (name, version, author)
- `.claude-plugin/marketplace.json` — marketplace catalog (lists plugins available for install)
- `settings.json` — default settings applied when plugin is enabled
- `hooks/hooks.json` — lifecycle hooks (auto-discovered by plugin system)
- `install-skills.sh` — standalone installer fallback (bash + git only)
- `action.yml` — GitHub Actions composite action wrapping the installer
- `manifest.json` — auto-generated index of all skills
