# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Plugin manifest (`.claude-plugin/plugin.json`) for native Claude Code plugin install
- Marketplace catalog (`.claude-plugin/marketplace.json`) for plugin discovery and install
- Default `settings.json` for plugin-level configuration
- Namespaced skill invocation (`/claude-team-plugin:<skill-name>`)
- Team auto-registration via `extraKnownMarketplaces` in settings.json

### Changed

- Simplified SKILL.md frontmatter to use plugin-native `description` field
- README and docs updated with marketplace install as primary method

## [v1.0.0] - 2026-03-30

### Added

- Initial plugin release
- Skills: grill-me, write-a-prd, prd-to-issues, tdd, improve-codebase-architecture
- Install script (`install-skills.sh`) with version pinning and selective install
- GitHub Actions composite action (`action.yml`)
- CI workflows for PR validation and tag-based releases
- Documentation: CONTRIBUTING.md, SKILL-SPEC.md
