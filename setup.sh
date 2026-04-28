#!/usr/bin/env bash
set -euo pipefail
SETUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Machine type?"
echo "  1) laptop"
echo "  2) server"
echo "  3) docker"
read -r -p "Choice [1-3]: " choice

case "$choice" in
    1) bash "$SETUP_DIR/profiles/laptop.sh" ;;
    2) bash "$SETUP_DIR/profiles/server.sh" ;;
    3) bash "$SETUP_DIR/profiles/docker.sh" ;;
    *) echo "Unknown choice: $choice"; exit 1 ;;
esac
