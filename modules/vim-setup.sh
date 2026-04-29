#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

DOTFILES="$(dirname "${BASH_SOURCE[0]}")/../dotfiles"

log "vim-setup: configuring vim..."

if [[ -f "$DOTFILES/.vimrc" ]]; then
    dst="$HOME/.vimrc"
    if [[ -f "$dst" && ! -f "${dst}.orig" ]]; then
        cp "$dst" "${dst}.orig"
        log "  backed up .vimrc -> .vimrc.orig"
    fi
    if ! cmp -s "$DOTFILES/.vimrc" "$dst" 2>/dev/null; then
        cp "$DOTFILES/.vimrc" "$dst"
        log "  installed .vimrc"
    fi
fi

if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git \
        "$HOME/.vim/bundle/Vundle.vim"
    log "  installed Vundle"
fi
vim +PluginInstall +qall >/dev/null 2>&1
log "  plugins up to date"

log "vim-setup: done"
