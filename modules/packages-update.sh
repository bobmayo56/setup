#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "packages-update: updating (OS=$OS)..."
pkg_update
log "packages-update: done"
