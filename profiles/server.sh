#!/usr/bin/env bash
set -euo pipefail
MODULES="$(cd "$(dirname "${BASH_SOURCE[0]}")/../modules" && pwd)"

source "$MODULES/lib.sh"
log "=== profile: server (OS=$OS) ==="

source "$MODULES/packages-update.sh"
source "$MODULES/packages-common.sh"
source "$MODULES/tools-install.sh"
source "$MODULES/bash-setup.sh"
source "$MODULES/vim-setup.sh"
source "$MODULES/git-setup.sh"
source "$MODULES/ssh-setup.sh"
source "$MODULES/aws-install.sh"

log "=== server setup complete ==="
