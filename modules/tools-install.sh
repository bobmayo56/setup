#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "tools-install: installing personal tools to ~/bin..."

TOOLS_DIR="$(dirname "${BASH_SOURCE[0]}")/../tools"
mkdir -p "$HOME/bin"
for tool in "$TOOLS_DIR"/*; do
    src="$tool"
    dst="$HOME/bin/$(basename "$tool")"
    [[ -f "$src" ]] || continue
    if cmp -s "$src" "$dst" 2>/dev/null; then
        continue
    fi
    cp "$src" "$dst"
    chmod +x "$dst"
    log "  installed tool: $(basename "$tool")"
done

log "tools-install: done"
