#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "packages-common: installing common packages (OS=$OS)..."

case "$OS" in
    macos)
        PACKAGES=(git curl wget openssl python3 jq p7zip htop tree ripgrep fzf bat)
        brew install "${PACKAGES[@]}"
        ;;
    debian)
        _sudo apt-get install -y \
            git curl wget openssl \
            lsof psmisc \
            python3 python3-pip python3-venv \
            jq 7zip uuid-runtime \
            htop tree build-essential \
            vim ripgrep fzf unzip bat
        ;;
    rhel)
        _sudo yum install -y \
            git curl wget openssl \
            lsof psmisc \
            python3 python3-pip \
            jq p7zip p7zip-plugins util-linux \
            htop tree gcc make \
            vim ripgrep fzf unzip bat
        ;;
    amzn)
        _sudo yum install -y \
            git curl wget openssl \
            lsof psmisc \
            python3 python3-pip \
            jq p7zip p7zip-plugins util-linux \
            htop tree \
            vim fzf unzip
        ;;
    alpine)
        apk add --no-cache \
            git curl wget openssl \
            lsof psmisc \
            python3 py3-pip \
            jq p7zip util-linux \
            htop tree \
            vim ripgrep fzf unzip bat
        ;;
    *)
        warn "unknown OS ($OS), skipping package install"
        ;;
esac

log "packages-common: done"
