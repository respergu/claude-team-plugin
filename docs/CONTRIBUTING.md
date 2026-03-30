# Contributing

## Adding a new skill

1. Create a directory under `skills/` with a lowercase-kebab-case name
2. Add a `SKILL.md` with YAML frontmatter (see [SKILL-SPEC.md](SKILL-SPEC.md))
3. Optionally add `references/` and `resources/` subdirectories for supporting files
4. Add the skill to `manifest.json`
5. Add a CHANGELOG entry under `[Unreleased]`
6. Open a PR

## Modifying an existing skill

1. Edit the `SKILL.md` or reference files
2. Bump the `metadata.version` in frontmatter if it's a significant change
3. Add a CHANGELOG entry under `[Unreleased]`
4. Open a PR

## Skill naming

- Use lowercase-kebab-case: `write-a-prd`, `grill-me`
- The frontmatter `name` field must exactly match the directory name
- Do not use the `fff-` prefix — that is reserved for project-specific local skills

## Testing locally

```bash
# Dry run to see what would be installed
./install-skills.sh --dry-run

# Install a specific skill into a test project
./install-skills.sh --skills "your-skill" --target /tmp/test-skills
```

## PR validation

CI automatically checks:
- Valid YAML frontmatter on every `SKILL.md`
- Frontmatter `name` matches directory name
- Required `description` field is present
- CHANGELOG has entries under `[Unreleased]`
- `manifest.json` is valid and includes all skills
- `shellcheck` passes on `install-skills.sh`

## Versioning

See the [README](../README.md#versioning) for semver guidelines.
