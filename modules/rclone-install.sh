#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if command_exists rclone; then
    log "rclone-install: already installed ($(rclone --version | head -1)), skipping"
    exit 0
fi

log "rclone-install: installing rclone (OS=$OS)..."

case "$OS" in
    macos)
        brew install rclone
        ;;
    debian|rhel|amzn|alpine|linux-unknown)
        curl -fsSL https://rclone.org/install.sh | sudo bash
        ;;
    *)
        die "Unsupported OS for rclone install: $OS"
        ;;
esac

log "rclone-install: done ($(rclone --version | head -1))"
