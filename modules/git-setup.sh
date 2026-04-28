#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

command_exists git || die "git not installed — run packages-common.sh first"

log "git-setup: configuring git..."

GIT_USER_NAME="${GIT_USER_NAME:-$(git config --global user.name 2>/dev/null)}"
GIT_USER_EMAIL="${GIT_USER_EMAIL:-$(git config --global user.email 2>/dev/null)}"
[[ -z "$GIT_USER_NAME" || -z "$GIT_USER_EMAIL" ]] && \
    die "Set GIT_USER_NAME and GIT_USER_EMAIL environment variables"

git config --global user.name  "$GIT_USER_NAME"
git config --global user.email "$GIT_USER_EMAIL"
git config --global core.editor        "${EDITOR:-vim}"
git config --global init.defaultBranch main
git config --global pull.rebase        false
git config --global push.autoSetupRemote true
git config --global core.excludesfile  "$HOME/.gitignore_global"

if [[ ! -f "$HOME/.gitignore_global" ]]; then
    cat > "$HOME/.gitignore_global" <<'EOF'
.DS_Store
*.swp
*.swo
.env
.secrets
.localrc
__pycache__/
*.pyc
.idea/
.vscode/
EOF
    log "  created ~/.gitignore_global"
fi

log "git-setup: done (name=$GIT_USER_NAME, email=$GIT_USER_EMAIL)"
