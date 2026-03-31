# claude-team-plugin

Multi-plugin marketplace for team development workflows. Distributes Claude Code
plugins for frontend, backend, and core shared skills.

## Plugins

| Plugin | Description | Install |
|---|---|---|
| **front-end-skills** | Frontend-focused skills | `/plugin install front-end-skills@claude-team-marketplace` |
| **back-end-skills** | Backend-focused skills | `/plugin install back-end-skills@claude-team-marketplace` |
| **core-skills** | Core shared skills | `/plugin install core-skills@claude-team-marketplace` |

### Skills per plugin

Each plugin currently ships with the `grill-me` skill as a scaffold:

| Skill | Description | Usage |
|---|---|---|
| grill-me | Relentless interviewing to stress-test plans and designs | `/front-end-skills:grill-me` `/back-end-skills:grill-me` `/core-skills:grill-me` |

## Installation

### Step 1: Register the marketplace (one-time)

```bash
/plugin marketplace add respergu/claude-team-plugin
```

### Step 2: Install the plugins you need

```bash
# Install one or more plugins
/plugin install front-end-skills@claude-team-marketplace --scope project
/plugin install back-end-skills@claude-team-marketplace --scope project
/plugin install core-skills@claude-team-marketplace --scope project
```

### Auto-registration for teams

Add to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "claude-team-marketplace": {
      "source": {
        "source": "github",
        "repo": "respergu/claude-team-plugin"
      }
    }
  }
}
```

Then each team member just runs:
```bash
/plugin install core-skills@claude-team-marketplace --scope project
```

### Local development

```bash
# Load a specific plugin from a local directory
claude --plugin-dir ./plugins/front-end-skills

# Or register the local marketplace
/plugin marketplace add ./
/plugin install front-end-skills@claude-team-marketplace
```

## Versioning

Each plugin is versioned independently in its own `plugin.json`. Tags follow semver (`v1.0.0`).

| Change | Bump |
|---|---|
| Removed skills, breaking changes | MAJOR |
| New skills, new rules | MINOR |
| Typo fixes, bug fixes | PATCH |

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) and [docs/SKILL-SPEC.md](docs/SKILL-SPEC.md).
