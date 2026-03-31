# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Restructured from single root-level plugin to **3 separate plugins** in `plugins/` directory:
  - `front-end-skills` — frontend-focused skills
  - `back-end-skills` — backend-focused skills
  - `core-skills` — core shared skills
- Updated marketplace.json to list all 3 plugins
- Each plugin scaffolded with `grill-me` skill
- Removed old root-level plugin files (plugin.json, skills/, hooks/, settings.json, .mcp.json, manifest.json, install-skills.sh, action.yml)

## [v1.0.0] - 2026-03-30

### Added

- Initial plugin release
- Skills: grill-me, write-a-prd, prd-to-issues, tdd, improve-codebase-architecture
- Install script (`install-skills.sh`) with version pinning and selective install
- GitHub Actions composite action (`action.yml`)
- CI workflows for PR validation and tag-based releases
- Documentation: CONTRIBUTING.md, SKILL-SPEC.md
