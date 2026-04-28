#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

SSH_CONFIG="$SETUP_DIR/ssh/config"

log "ssh-setup: installing ssh config..."

mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

safe_symlink "$SSH_CONFIG" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

log "ssh-setup: done"
