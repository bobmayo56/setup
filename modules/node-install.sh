#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
NODE_VERSION="${NODE_VERSION:-lts/*}"

if command_exists node; then
    log "node-install: already installed ($(node --version)), skipping"
    exit 0
fi

log "node-install: installing nvm..."
curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh" | bash

source_if_exists "$NVM_DIR/nvm.sh"
command_exists nvm || die "nvm install failed"

log "node-install: installing Node $NODE_VERSION..."
nvm install "$NODE_VERSION"
nvm alias default "$NODE_VERSION"

NVM_LINE='export NVM_DIR="$HOME/.nvm"; [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"'
append_if_missing "$HOME/.bashrc" "$NVM_LINE"
append_if_missing "$HOME/.zshrc"  "$NVM_LINE"

log "node-install: done ($(node --version))"
