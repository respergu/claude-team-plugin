---
name: prd-to-issues
description: Convert a PRD into actionable GitHub issues
allowed-tools: Agent, Read, Glob, Grep, Bash
model: sonnet
tags: planning, project-management
format-version: 1
user-invocable: true
metadata:
  author: mattpocock
  version: 1.0.0
---

Convert a Product Requirements Document (PRD) into individual, actionable GitHub issues.

## Process

### 1. Read the PRD

Read the PRD provided by the user (as a GitHub issue URL, file path, or pasted text). Identify:
- All user stories
- Implementation decisions and modules
- Testing requirements
- Dependencies between components

### 2. Plan the Issue Breakdown

Present a numbered list of proposed issues to the user before creating them. Each issue should:
- Be a single, deliverable unit of work
- Have clear acceptance criteria derived from the PRD
- Be sized for one PR (roughly 1-3 days of work)
- Include relevant context from the PRD without duplicating the entire document

Ask the user to confirm or adjust the breakdown.

### 3. Create Issues

For each approved issue, create a GitHub issue using `gh issue create` with:

**Title:** Short, imperative description (e.g., "Add authentication middleware for API routes")

**Body:**
```
## Context
Link back to the parent PRD issue.

## Requirements
- Bullet points derived from the PRD's user stories and implementation decisions.

## Acceptance Criteria
- [ ] Checkboxes for each verifiable outcome.

## Dependencies
- Links to other issues that must be completed first (if any).

## Testing
- What tests should be written for this issue.
```

### 4. Summary

After creating all issues, provide a summary with:
- List of created issues with URLs
- A suggested implementation order based on dependencies
- Any items from the PRD that were intentionally left out and why
