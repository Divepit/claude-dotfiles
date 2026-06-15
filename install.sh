#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

mkdir -p "$CLAUDE_DIR/agents"

cp "$DOTFILES_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
cp "$DOTFILES_DIR/agents/"*.md "$CLAUDE_DIR/agents/"

echo "Installed to $CLAUDE_DIR"
