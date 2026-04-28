#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

DOTFILES="$SETUP_DIR/../dotfiles"

log "zsh-setup: configuring zsh..."

for f in .zshrc .zlogin; do
    src="$DOTFILES/$f"
    dst="$HOME/$f"
    [[ -f "$src" ]] || continue
    if cmp -s "$src" "$dst" 2>/dev/null; then
        continue
    fi
    cp "$src" "$dst"
    log "  installed $f"
done

# Ensure ~/.zshrc sources secrets and localrc
append_if_missing "$HOME/.zshrc" '[[ -f ~/.secrets ]] && source ~/.secrets'
append_if_missing "$HOME/.zshrc" '[[ -f ~/.localrc ]] && source ~/.localrc'
append_if_missing "$HOME/.zshrc" 'export PATH="$HOME/bin:$PATH"'

log "zsh-setup: done"
