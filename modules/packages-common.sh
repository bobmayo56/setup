#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "packages-common: installing common packages (OS=$OS)..."

case "$OS" in
    macos)
        PACKAGES=(git curl wget openssl python3 jq p7zip htop tree)
        brew install "${PACKAGES[@]}"
        ;;
    debian)
        sudo apt-get install -y \
            git curl wget openssl \
            python3 python3-pip python3-venv \
            jq p7zip-full uuid-runtime \
            htop tree build-essential
        ;;
    rhel)
        sudo yum install -y \
            git curl wget openssl \
            python3 python3-pip \
            jq p7zip p7zip-plugins util-linux \
            htop tree gcc make
        ;;
    amzn)
        sudo yum install -y \
            git curl wget openssl \
            python3 python3-pip \
            jq p7zip p7zip-plugins util-linux \
            htop tree
        ;;
    alpine)
        apk add --no-cache \
            git curl wget openssl \
            python3 py3-pip \
            jq p7zip util-linux \
            htop tree
        ;;
    *)
        warn "unknown OS ($OS), skipping package install"
        ;;
esac

log "packages-common: done"
