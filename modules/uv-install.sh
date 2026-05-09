#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if command_exists uv; then
    log "uv-install: already installed ($(uv --version)), skipping"
    exit 0
fi

log "uv-install: installing uv..."

case "$OS" in
    macos)
        brew install uv
        ;;
    debian|rhel|amzn|alpine|linux-unknown)
        curl -LsSf https://astral.sh/uv/install.sh | sh
        ;;
    *)
        die "Unsupported OS for uv install: $OS"
        ;;
esac

log "uv-install: done"
