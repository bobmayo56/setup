#!/usr/bin/env bash
set -euo pipefail
MODULES="$(cd "$(dirname "${BASH_SOURCE[0]}")/../modules" && pwd)"

source "$MODULES/lib.sh"
log "=== profile: docker (OS=$OS) ==="

source "$MODULES/packages-common.sh"
source "$MODULES/tools-install.sh"
source "$MODULES/bash-setup.sh"
source "$MODULES/vim-setup.sh"

log "=== docker setup complete ==="
