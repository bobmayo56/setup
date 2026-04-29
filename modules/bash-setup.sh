#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

DOTFILES="$SETUP_DIR/dotfiles"

log "bash-setup: configuring bash..."

# --- Install our dotfiles (vendors never touch these) ---
OWN_DOTFILES=(.alias .bash_interactive .bash_logout .exports .mkshrc .mongorc.js .npmrc .profile)
for f in "${OWN_DOTFILES[@]}"; do
    src="$DOTFILES/$f"
    dst="$HOME/$f"
    [[ -f "$src" ]] || continue
    if [[ -f "$dst" && ! -f "${dst}.orig" ]]; then
        cp "$dst" "${dst}.orig"
        log "  backed up $f -> $f.orig"
    fi
    if cmp -s "$src" "$dst" 2>/dev/null; then
        continue
    fi
    cp "$src" "$dst"
    log "  installed $f"
done

# --- Inject into system-touched files (never overwrite) ---
# Ensure login shells load .bashrc
append_if_missing "$HOME/.bash_profile" '[[ -f ~/.bashrc ]] && source ~/.bashrc'

# Wire our interactive config and personal additions into .bashrc
append_if_missing "$HOME/.bashrc" '[[ -f ~/.bash_interactive ]] && source ~/.bash_interactive'
append_if_missing "$HOME/.bashrc" '[[ -f ~/.exports ]] && source ~/.exports'
append_if_missing "$HOME/.bashrc" '[[ -f ~/.secrets ]] && source ~/.secrets'
append_if_missing "$HOME/.bashrc" '[[ -f ~/.localrc ]] && source ~/.localrc'

# --- Create ~/.secrets template if not present ---
if [[ ! -f "$HOME/.secrets" ]]; then
    cat > "$HOME/.secrets" <<'EOF'
# ~/.secrets — sourced by ~/.bashrc on every shell start
# This file is NOT in git. Store credentials and API keys here.
#
# Examples:
# export OPENAI_API_KEY="sk-..."
# export ANTHROPIC_API_KEY="..."
# export AWS_ACCESS_KEY_ID="..."
# export AWS_SECRET_ACCESS_KEY="..."
# export GITHUB_TOKEN="ghp_..."
#
# npm auth token (add to ~/.npmrc or set here as needed):
# export NPM_TOKEN="..."
EOF
    log "  created ~/.secrets template"
fi

# --- Create ~/.localrc template if not present ---
if [[ ! -f "$HOME/.localrc" ]]; then
    cat > "$HOME/.localrc" <<'EOF'
# ~/.localrc — machine-specific PATH additions and aliases (not in git)
export PATH="$HOME/bin:$PATH"

# Examples:
# export PATH="/opt/riscv/bin:$PATH"
# export PATH="$HOME/proj/apache-cassandra-3.10/bin:$PATH"
# export DYLD_LIBRARY_PATH="./node_modules/ibm_db/installer/clidriver/lib/icc"
EOF
    log "  created ~/.localrc template"
fi

log "bash-setup: done"
