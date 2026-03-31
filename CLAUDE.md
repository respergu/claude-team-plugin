# claude-team-plugin

Multi-plugin marketplace for the team. Each plugin targets a different domain
(frontend, backend, core) and bundles its own skills, hooks, and settings.

## Marketplace structure

This repo is a **plugin marketplace** containing multiple plugins:

- `.claude-plugin/marketplace.json` — marketplace catalog listing all plugins
- `plugins/<name>/` — each plugin is self-contained with its own manifest

Each plugin under `plugins/` has:
- `.claude-plugin/plugin.json` — plugin manifest (name, version, author)
- `skills/<name>/SKILL.md` — skills (invoked as `/<plugin-name>:<skill-name>`)
- `hooks/hooks.json` — lifecycle hooks (fire automatically when plugin is enabled)
- `settings.json` — default settings (applied when plugin is enabled)

## Plugins

| Plugin | Directory | Description |
|---|---|---|
| `front-end-skills` | `plugins/front-end-skills/` | Frontend-focused skills |
| `back-end-skills` | `plugins/back-end-skills/` | Backend-focused skills |
| `core-skills` | `plugins/core-skills/` | Core shared skills |

## How to add a skill

1. Choose the appropriate plugin under `plugins/`
2. Create `skills/<skill-name>/SKILL.md` with YAML frontmatter
3. Skill name must be lowercase-kebab-case and match the directory name
4. Bump the plugin's version in its `plugin.json`
5. Add a CHANGELOG entry under `[Unreleased]`
6. Open a PR

## How to add a new plugin

1. Create `plugins/<plugin-name>/` with the standard structure
2. Add `.claude-plugin/plugin.json` with name, version, description
3. Add at least one skill under `skills/`
4. Add `hooks/hooks.json` and `settings.json`
5. Add the plugin to `.claude-plugin/marketplace.json`
6. Update the README

## Naming conventions

- Plugin directories: `lowercase-kebab-case`
- Skill directories: `lowercase-kebab-case`
- Frontmatter `description` field is required
