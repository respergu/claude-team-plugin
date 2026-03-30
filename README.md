# claude-team-plugin

Shared Claude Code plugin for team development workflows. Centralizes reusable
AI-assisted skills so every repo gets the same capabilities.

## Skills

| Skill | Description | Usage |
|---|---|---|
| [grill-me](skills/grill-me/) | Relentless interviewing to stress-test plans and designs | `/claude-team-plugin:grill-me` |
| [write-a-prd](skills/write-a-prd/) | Collaborative PRD creation through structured interviews | `/claude-team-plugin:write-a-prd` |
| [prd-to-issues](skills/prd-to-issues/) | Convert a PRD into actionable GitHub issues | `/claude-team-plugin:prd-to-issues` |
| [tdd](skills/tdd/) | Test-driven development with vertical slices | `/claude-team-plugin:tdd` |
| [improve-codebase-architecture](skills/improve-codebase-architecture/) | Surface architectural friction and propose deep-module refactors | `/claude-team-plugin:improve-codebase-architecture` |

## Installation

### Plugin install (recommended)

```bash
# Install for yourself
claude plugin install claude-team-plugin

# Install for the whole project (committed to .claude/settings.json)
claude plugin install claude-team-plugin --scope project
```

Skills are automatically namespaced — use `/claude-team-plugin:skill-name` to invoke them. Hooks and settings are applied automatically when the plugin is enabled.

### Local development

```bash
# Load the plugin from a local directory
claude --plugin-dir ./claude-team-plugin
```

### Alternative: Install script

For CI environments or setups without the Claude Code CLI:

```bash
# Install all skills
./install-skills.sh

# Install specific skills at a pinned version
./install-skills.sh --version v1.0.0 --skills "grill-me,tdd"

# Dry run
./install-skills.sh --dry-run
```

### Alternative: GitHub Actions

```yaml
steps:
  - uses: actions/checkout@v4
  - uses: respergu/claude-team-plugin@v1
    with:
      version: v1.0.0
      skills: "grill-me,tdd"
```

### Alternative: Config file

Create `.agent-skills.json` in your repo (see [.agent-skills.json.example](.agent-skills.json.example)):

```json
{
  "version": "v1.0.0",
  "target": ".claude/skills",
  "skills": ["grill-me", "tdd", "write-a-prd"]
}
```

Then run `./install-skills.sh` with no arguments — it reads the config automatically.

## Versioning

Tags follow semver (`v1.0.0`). A floating major tag (`v1`) points to the latest `v1.x.x`.

| Change | Bump |
|---|---|
| Removed skills, breaking changes, skill format changes | MAJOR |
| New skills, new rules in existing skills, new features | MINOR |
| Typo fixes, wording improvements, bug fixes | PATCH |

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) and [docs/SKILL-SPEC.md](docs/SKILL-SPEC.md).
