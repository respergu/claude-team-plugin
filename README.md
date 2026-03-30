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

### Step 1: Register the marketplace (one-time)

```bash
# Via GitHub shorthand
/plugin marketplace add respergu/claude-team-plugin
```

### Step 2: Install the plugin

```bash
# Install for yourself
/plugin install claude-team-plugin@claude-team-marketplace

# Install for the whole project (committed to .claude/settings.json)
claude plugin install claude-team-plugin@claude-team-marketplace --scope project
```

Skills are automatically namespaced — use `/claude-team-plugin:skill-name` to invoke them. Hooks and settings are applied automatically when the plugin is enabled.

### Auto-registration for teams

Add to your project's `.claude/settings.json` so every team member gets the marketplace automatically:

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
/plugin install claude-team-plugin@claude-team-marketplace
```

### Local development

```bash
# Load the plugin directly from a local directory
claude --plugin-dir ./claude-team-plugin

# Or register as a local marketplace
/plugin marketplace add ./
/plugin install claude-team-plugin@claude-team-marketplace
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

## Plugin vs `install-skills.sh` — Why we recommend the plugin

This repo supports two installation approaches. **We recommend the plugin marketplace** for team use because it treats skills, hooks, settings, and resources as a single distributable unit — not loose files to copy around.

| Aspect | Plugin + Marketplace | `install-skills.sh` |
|---|---|---|
| **Install** | `/plugin install claude-team-plugin@claude-team-marketplace` | Run bash script, manage config file |
| **What gets installed** | Skills, hooks, settings, resources — everything | Skills only (copies `SKILL.md` files) |
| **Hooks** | Fire automatically when plugin is enabled | Must be set up manually per project |
| **Namespacing** | Automatic: `/claude-team-plugin:grill-me` — no conflicts | Flat: `/grill-me` — can collide with other skills |
| **Updates** | `claude plugin update` with version detection | Manual re-run; no update awareness |
| **Team rollout** | Add `extraKnownMarketplaces` to `.claude/settings.json` — done | Every dev runs the script or CI does it |
| **Config** | `userConfig` can prompt for values (API keys, preferences) | No config mechanism |
| **Persistent data** | `${CLAUDE_PLUGIN_DATA}` directory survives updates | No persistence concept |
| **Versioning** | Semver in `plugin.json`; Claude Code detects new versions | `.skills-version` file; no detection |

### Why the plugin approach matters for teams

The bash script copies skill files, but a team needs more than prompts — it needs **shared hooks** (e.g., pre-commit checks, cleanup automation), **default settings** (model preferences, permission modes), and **reference resources** (templates, specs). The plugin system bundles all of these into a single installable package that stays in sync across the team.

With the marketplace, onboarding a new developer is one command. With the script, it's "clone this, run that, also copy these hooks, and don't forget to set these settings." The plugin eliminates that friction.

The install script and GitHub Actions composite action remain available as **fallbacks** for CI environments or setups where the Claude Code CLI isn't available.

## Versioning

Tags follow semver (`v1.0.0`). A floating major tag (`v1`) points to the latest `v1.x.x`.

| Change | Bump |
|---|---|
| Removed skills, breaking changes, skill format changes | MAJOR |
| New skills, new rules in existing skills, new features | MINOR |
| Typo fixes, wording improvements, bug fixes | PATCH |

## Contributing

See [docs/CONTRIBUTING.md](docs/CONTRIBUTING.md) and [docs/SKILL-SPEC.md](docs/SKILL-SPEC.md).
