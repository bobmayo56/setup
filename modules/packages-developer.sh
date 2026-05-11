#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "packages-developer: installing developer tools..."

# --- Claude Code ---
if command_exists claude; then
    log "packages-developer: claude already installed ($(claude --version 2>/dev/null || echo unknown)), skipping"
else
    # Ensure npm is reachable (nvm users need the shell integration sourced first)
    NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
    source_if_exists "$NVM_DIR/nvm.sh"

    command_exists npm || die "npm not found — run 'make install-node' first"

    log "packages-developer: installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
    log "packages-developer: claude installed ($(claude --version 2>/dev/null || echo ok))"
fi

log "packages-developer: done"
