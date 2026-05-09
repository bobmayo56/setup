#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

log "geospatial-install: installing geospatial/climate packages (OS=$OS)..."

case "$OS" in
    debian)
        _sudo apt-get install -y \
            libgdal-dev \
            libeccodes-dev \
            netcdf-bin \
            ncview \
            libnetcdf-dev \
            libhdf5-dev
        ;;
    *)
        warn "geospatial-install: no package list for OS=$OS, skipping"
        ;;
esac

log "geospatial-install: done"
