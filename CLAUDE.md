# claude-team-plugin

Shared Claude Code skills repository for the team. Centralizes reusable AI-assisted
development workflows so every repo gets the same capabilities.

## Repository purpose

This repo distributes Claude Code skills via:
1. **Direct install** — `install-skills.sh` copies skills into any repo's `.claude/skills/`
2. **GitHub Actions** — `action.yml` composite action for CI pipelines

## How to add a skill

1. Create `skills/<skill-name>/SKILL.md` with YAML frontmatter (see `docs/SKILL-SPEC.md`)
2. Skill name must be lowercase-kebab-case and match the directory name
3. Add any reference files under `skills/<skill-name>/references/`
4. Update `manifest.json` (or let CI regenerate it on release)
5. Add a CHANGELOG entry under `[Unreleased]`
6. Open a PR — CI will validate frontmatter, naming, and changelog

## Naming conventions

- Skill directories: `lowercase-kebab-case`
- Frontmatter `name` field must exactly match directory name
- No `fff-` prefix — that's reserved for project-specific local skills

## Key files

- `install-skills.sh` — standalone installer (bash + git only)
- `action.yml` — GitHub Actions composite action wrapping the installer
- `manifest.json` — auto-generated index of all skills
- `.agent-skills.json` — config file for consuming repos (see `.agent-skills.json.example`)
