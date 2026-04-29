#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "zsh-setup: configuring zsh..."

# Inject into ~/.zshrc (never overwrite — vendor may have put things there)
append_if_missing "$HOME/.zshrc" '[[ -f ~/.alias ]] && source ~/.alias'
append_if_missing "$HOME/.zshrc" 'alias pip3="python3 -m pip"'
append_if_missing "$HOME/.zshrc" '[[ -f ~/.secrets ]] && source ~/.secrets'
append_if_missing "$HOME/.zshrc" '[[ -f ~/.localrc ]] && source ~/.localrc'

log "zsh-setup: done"
