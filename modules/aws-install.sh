#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if command_exists aws; then
    log "aws-install: already installed ($(aws --version 2>&1)), skipping"
    exit 0
fi

log "aws-install: installing AWS CLI v2 (OS=$OS)..."

case "$OS" in
    macos)
        brew install awscli
        ;;
    debian|rhel|amzn|linux-unknown)
        TMP="$(mktemp -d)"
        curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$TMP/awscliv2.zip"
        unzip -q "$TMP/awscliv2.zip" -d "$TMP"
        sudo "$TMP/aws/install"
        rm -rf "$TMP"
        ;;
    alpine)
        pip3 install awscli
        ;;
    *)
        die "Unsupported OS for AWS CLI install: $OS"
        ;;
esac

log "aws-install: done ($(aws --version 2>&1))"
