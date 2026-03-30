# Skill Specification

Skills use YAML frontmatter followed by Markdown content.

## File format

```markdown
---
name: skill-name
description: One-line description of what the skill does
allowed-tools: Agent, Read, Glob, Grep
model: sonnet
tags: category1, category2
format-version: 1
user-invocable: true
metadata:
  author: author-name
  version: 1.0.0
---

Skill prompt content goes here...
```

## Fields

### Required

| Field | Type | Description |
|---|---|---|
| `name` | string | Skill identifier. Must be lowercase-kebab-case and match the directory name. |
| `description` | string | One-line description. Used in manifest and discovery. |

### Optional

| Field | Type | Default | Description |
|---|---|---|---|
| `allowed-tools` | string | _(all)_ | Comma-separated list of tools the skill can use. |
| `model` | string | _(inherited)_ | Recommended Claude model: `haiku`, `sonnet`, or `opus`. |
| `tags` | string | _(none)_ | Comma-separated taxonomy tags for discovery and filtering. |
| `format-version` | number | `1` | Skill spec version. Used for future migration. |
| `user-invocable` | boolean | `true` | Set to `false` to hide from slash commands. |
| `license` | string | _(none)_ | License identifier (e.g., `MIT`). |
| `metadata.author` | string | _(none)_ | Skill author or source attribution. |
| `metadata.version` | string | _(none)_ | Version of the skill content itself. |

## Directory structure

```
skills/
└── my-skill/
    ├── SKILL.md          # Required — skill definition with frontmatter
    ├── references/       # Optional — reference documents
    │   └── REFERENCE.md
    └── resources/        # Optional — supporting files (scripts, templates)
```

## Guidelines

- Keep the prompt content focused and actionable
- Use `model: opus` only for skills that genuinely need extended reasoning (architecture, PRD writing)
- Use `model: sonnet` for interactive skills (interviews, TDD loops)
- Use `model: haiku` for simple, fast skills (formatting, lookup)
- Tags should be lowercase, common categories: `planning`, `testing`, `development`, `architecture`, `refactoring`, `documentation`, `review`, `project-management`
