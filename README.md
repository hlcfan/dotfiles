# dotfiles

## Install agent instructions and skills

Run `./install-agents.sh` from the repository root. Requires Bash and rsync.

| Agent | Global instructions | User skills |
| --- | --- | --- |
| Codex | `${CODEX_HOME:-$HOME/.codex}/AGENTS.md` | `~/.agents/skills/` |
| Claude Code | `~/.claude/CLAUDE.md` | `~/.claude/skills/` |

Edit the shared instructions in `AGENTS.md` or skills under `.agents/skills/`, then rerun the script.
The script overwrites the instruction files and refreshes each included skill.
It preserves unrelated skill folders and leaves global skill registries untouched.
Removing a skill from this repository does not remove its installed copies.

## Add generic password

    security add-generic-password -a ${USER} -s playground -w $(pwgen)
