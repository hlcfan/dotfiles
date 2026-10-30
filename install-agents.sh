#!/usr/bin/env bash
# Copy shared instructions and skills to Codex and Claude Code's user locations.
set -euo pipefail

main() {
  local repo codex_home
  repo="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  codex_home="${CODEX_HOME:-$HOME/.codex}"

  mkdir -p "$codex_home" "$HOME/.agents/skills" "$HOME/.claude/skills"

  sync_skills "$repo/.agents/skills" "$HOME/.agents/skills"
  sync_skills "$repo/.agents/skills" "$HOME/.claude/skills"

  cp "$repo/AGENTS.md" "$codex_home/AGENTS.md"
  cp "$repo/AGENTS.md" "$HOME/.claude/CLAUDE.md"
}

# Update each skill from the repo; other entries (e.g. Claude's synced/) are left alone.
sync_skills() {
  local src="$1" dest="$2" skill
  for skill in "$src"/*/; do
    rsync -a --delete "$skill" "$dest/$(basename "$skill")/"
  done
}

main "$@"
