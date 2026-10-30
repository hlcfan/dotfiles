#!/usr/bin/env bash
# Copy agent config from this repo to where Claude Code and other agents read it.
set -euo pipefail

main() {
  local repo
  repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/.agents"

  mkdir -p "$HOME/.agents/skills" "$HOME/.claude/skills"

  sync_skills "$repo/skills" "$HOME/.agents/skills"
  sync_skills "$repo/skills" "$HOME/.claude/skills"

  cp "$repo/AGENTS.md" "$HOME/.agents/AGENTS.md"
  cp "$repo/AGENTS.md" "$HOME/.claude/CLAUDE.md"
  cp "$repo/.skill-lock.json" "$HOME/.agents/.skill-lock.json"
}

# Update each skill from the repo; other entries (e.g. Claude's synced/) are left alone.
sync_skills() {
  local src="$1" dest="$2" skill
  for skill in "$src"/*/; do
    rsync -a --delete "$skill" "$dest/$(basename "$skill")/"
  done
}

main "$@"
