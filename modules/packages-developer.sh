#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "packages-developer: installing developer tools..."

# --- Node / nvm ---
NVM_DIR="${NVM_DIR:-$HOME/.nvm}"
NODE_VERSION="${NODE_VERSION:-lts/*}"

if command_exists node; then
    log "packages-developer: node already installed ($(node --version)), skipping"
else
    log "packages-developer: installing nvm..."
    curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh" | bash
    source_if_exists "$NVM_DIR/nvm.sh"
    command_exists nvm || die "nvm install failed"
    log "packages-developer: installing Node $NODE_VERSION..."
    nvm install "$NODE_VERSION"
    nvm alias default "$NODE_VERSION"
    NVM_LINE='export NVM_DIR="$HOME/.nvm"; [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"'
    append_if_missing "$HOME/.bashrc" "$NVM_LINE"
    append_if_missing "$HOME/.zshrc"  "$NVM_LINE"
    log "packages-developer: node installed ($(node --version))"
fi

# --- AWS CLI ---
if command_exists aws; then
    log "packages-developer: aws already installed ($(aws --version 2>&1)), skipping"
else
    log "packages-developer: installing AWS CLI v2 (OS=$OS)..."
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
    log "packages-developer: aws installed ($(aws --version 2>&1))"
fi

# --- rclone ---
if command_exists rclone; then
    log "packages-developer: rclone already installed ($(rclone --version | head -1)), skipping"
else
    log "packages-developer: installing rclone (OS=$OS)..."
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
    log "packages-developer: rclone installed ($(rclone --version | head -1))"
fi

# --- uv ---
if command_exists uv; then
    log "packages-developer: uv already installed ($(uv --version)), skipping"
else
    log "packages-developer: installing uv..."
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
    log "packages-developer: uv installed"
fi

# --- Claude Code ---
source_if_exists "$NVM_DIR/nvm.sh"

if command_exists claude; then
    log "packages-developer: claude already installed ($(claude --version 2>/dev/null || echo unknown)), skipping"
else
    command_exists npm || die "npm not found"
    log "packages-developer: installing Claude Code..."
    npm install -g @anthropic-ai/claude-code
    log "packages-developer: claude installed ($(claude --version 2>/dev/null || echo ok))"
fi

log "packages-developer: done"
