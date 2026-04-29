#!/usr/bin/env bash
set -euo pipefail
MODULES="$(cd "$(dirname "${BASH_SOURCE[0]}")/../modules" && pwd)"

source "$MODULES/lib.sh"
log "=== profile: laptop (OS=$OS) ==="

source "$MODULES/packages-update.sh"
source "$MODULES/packages-common.sh"
source "$MODULES/tools-install.sh"
source "$MODULES/bash-setup.sh"
source "$MODULES/zsh-setup.sh"
source "$MODULES/git-setup.sh"
source "$MODULES/ssh-setup.sh"
source "$MODULES/node-install.sh"
source "$MODULES/aws-install.sh"

log "=== laptop setup complete ==="
