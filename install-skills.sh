#!/usr/bin/env bash
set -euo pipefail

# install-skills.sh — Install Claude Code skills from the shared repository.
# Dependencies: bash, git

REPO_URL="https://github.com/respergu/claude-team-plugin.git"
DEFAULT_TARGET=".claude/skills"
SKILLS_DIR="skills"

# Defaults
VERSION=""
SKILLS=""
TARGET="$DEFAULT_TARGET"
LOCAL_SOURCE=""
DRY_RUN=false
CONFIG_FILE=".agent-skills.json"

usage() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Install Claude Code skills into a project.

Options:
  --version VERSION      Pin to a specific semver tag (e.g., v1.0.0)
  --skills SKILLS        Comma-separated list of skill names to install
  --target DIR           Target directory (default: $DEFAULT_TARGET)
  --local-source DIR     Use a pre-cloned repo instead of fetching
  --dry-run              Show what would be installed without making changes
  -h, --help             Show this help message

If no --skills flag is provided and a $CONFIG_FILE exists, configuration
is read from that file.

Examples:
  $(basename "$0")                                    # Install all skills
  $(basename "$0") --version v1.2.0                   # Pin to a version
  $(basename "$0") --skills "grill-me,tdd"            # Install specific skills
  $(basename "$0") --target .agents/skills             # Custom target
  $(basename "$0") --local-source /path/to/repo        # Use local clone
  $(basename "$0") --dry-run                           # Preview changes
EOF
  exit 0
}

log() { echo "[install-skills] $*"; }
warn() { echo "[install-skills] WARNING: $*" >&2; }
die() { echo "[install-skills] ERROR: $*" >&2; exit 1; }

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)    VERSION="$2"; shift 2 ;;
    --skills)     SKILLS="$2"; shift 2 ;;
    --target)     TARGET="$2"; shift 2 ;;
    --local-source) LOCAL_SOURCE="$2"; shift 2 ;;
    --dry-run)    DRY_RUN=true; shift ;;
    -h|--help)    usage ;;
    *)            die "Unknown option: $1" ;;
  esac
done

# Read config file if no --skills flag and config exists
if [[ -z "$SKILLS" && -f "$CONFIG_FILE" ]]; then
  log "Reading configuration from $CONFIG_FILE"

  if command -v jq &>/dev/null; then
    CONFIG_VERSION=$(jq -r '.version // empty' "$CONFIG_FILE" 2>/dev/null || true)
    CONFIG_TARGET=$(jq -r '.target // empty' "$CONFIG_FILE" 2>/dev/null || true)
    CONFIG_SKILLS=$(jq -r '.skills // [] | join(",")' "$CONFIG_FILE" 2>/dev/null || true)
  elif command -v python3 &>/dev/null; then
    CONFIG_VERSION=$(python3 -c "import json,sys; d=json.load(open('$CONFIG_FILE')); print(d.get('version',''))" 2>/dev/null || true)
    CONFIG_TARGET=$(python3 -c "import json,sys; d=json.load(open('$CONFIG_FILE')); print(d.get('target',''))" 2>/dev/null || true)
    CONFIG_SKILLS=$(python3 -c "import json,sys; d=json.load(open('$CONFIG_FILE')); print(','.join(d.get('skills',[])))" 2>/dev/null || true)
  else
    warn "Neither jq nor python3 found — cannot parse $CONFIG_FILE. Install jq or pass --skills."
  fi

  [[ -z "$VERSION" && -n "${CONFIG_VERSION:-}" ]] && VERSION="$CONFIG_VERSION"
  [[ "$TARGET" == "$DEFAULT_TARGET" && -n "${CONFIG_TARGET:-}" ]] && TARGET="$CONFIG_TARGET"
  [[ -z "$SKILLS" && -n "${CONFIG_SKILLS:-}" ]] && SKILLS="$CONFIG_SKILLS"
fi

# Resolve source directory
TEMP_DIR=""
cleanup() {
  if [[ -n "$TEMP_DIR" && -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
  fi
}
trap cleanup EXIT

if [[ -n "$LOCAL_SOURCE" ]]; then
  [[ -d "$LOCAL_SOURCE/$SKILLS_DIR" ]] || die "Local source '$LOCAL_SOURCE' does not contain a '$SKILLS_DIR/' directory"
  SOURCE_DIR="$LOCAL_SOURCE"
  log "Using local source: $SOURCE_DIR"
else
  # Resolve version — use latest tag if not specified, fall back to default branch
  if [[ -z "$VERSION" ]]; then
    VERSION=$(git ls-remote --tags --sort=-v:refname "$REPO_URL" 2>/dev/null \
      | grep -oE 'refs/tags/v[0-9]+\.[0-9]+\.[0-9]+$' \
      | head -1 \
      | sed 's|refs/tags/||' || true)
    if [[ -n "$VERSION" ]]; then
      log "Resolved latest version: $VERSION"
    else
      log "No version tags found — using default branch"
    fi
  fi

  TEMP_DIR=$(mktemp -d)

  # Use GITHUB_TOKEN if available (CI environments)
  CLONE_URL="$REPO_URL"
  if [[ -n "${GITHUB_TOKEN:-}" ]]; then
    CLONE_URL="${REPO_URL/https:\/\//https://x-access-token:${GITHUB_TOKEN}@}"
  fi

  if [[ -n "$VERSION" ]]; then
    log "Cloning $REPO_URL at $VERSION..."
    git clone --depth 1 --branch "$VERSION" "$CLONE_URL" "$TEMP_DIR" 2>/dev/null \
      || die "Failed to clone $REPO_URL at $VERSION"
  else
    log "Cloning $REPO_URL (default branch)..."
    git clone --depth 1 "$CLONE_URL" "$TEMP_DIR" 2>/dev/null \
      || die "Failed to clone $REPO_URL"
  fi

  SOURCE_DIR="$TEMP_DIR"
fi

# Build list of skills to install
if [[ -n "$SKILLS" ]]; then
  IFS=',' read -ra SKILL_LIST <<< "$SKILLS"
else
  SKILL_LIST=()
  for dir in "$SOURCE_DIR/$SKILLS_DIR"/*/; do
    [[ -d "$dir" ]] || continue
    SKILL_LIST+=("$(basename "$dir")")
  done
fi

[[ ${#SKILL_LIST[@]} -gt 0 ]] || die "No skills found to install"

# Check for name collisions with global skills
GLOBAL_SKILLS_DIR="$HOME/.claude/skills"
for skill in "${SKILL_LIST[@]}"; do
  skill=$(echo "$skill" | xargs)  # trim whitespace
  if [[ -d "$GLOBAL_SKILLS_DIR/$skill" ]]; then
    warn "Skill '$skill' exists in global ~/.claude/skills/ — project-local copy will take precedence"
  fi
done

# Install skills
log "Installing ${#SKILL_LIST[@]} skill(s) into $TARGET/"

for skill in "${SKILL_LIST[@]}"; do
  skill=$(echo "$skill" | xargs)  # trim whitespace
  skill_src="$SOURCE_DIR/$SKILLS_DIR/$skill"

  if [[ ! -d "$skill_src" ]]; then
    warn "Skill '$skill' not found in source — skipping"
    continue
  fi

  if $DRY_RUN; then
    log "[dry-run] Would install: $skill -> $TARGET/$skill/"
  else
    mkdir -p "$TARGET/$skill"
    cp -R "$skill_src"/* "$TARGET/$skill/"
    log "Installed: $skill"
  fi
done

# Write version metadata
if ! $DRY_RUN; then
  cat > "$TARGET/../.skills-version" <<EOF
source: $REPO_URL
version: ${VERSION:-local}
skills: $(IFS=','; echo "${SKILL_LIST[*]}")
installed: $(date -u +"%Y-%m-%dT%H:%M:%SZ")
EOF
  log "Wrote .skills-version"
fi

log "Done."
