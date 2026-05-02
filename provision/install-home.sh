#!/bin/sh
# Install home_template/ into $HOME.
# Before overwriting a file, save the original as .orig — but only once.

SETUP_DIR="$(cd "$(dirname "$0")/.." && pwd)"
TEMPLATE="$SETUP_DIR/home_template"

find "$TEMPLATE" -type f | while IFS= read -r src; do
    rel="${src#$TEMPLATE/}"
    dest="$HOME/$rel"
    if [ -f "$dest" ] && [ ! -f "$dest.orig" ] && [ "${rel#bin/}" = "$rel" ]; then
        cp "$dest" "$dest.orig"
        echo "Backed up: ~/$rel -> ~/$rel.orig"
    fi
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    echo "Installed: ~/$rel"
done

chmod 700 "$HOME/.ssh"
chmod 600 "$HOME/.ssh/config"
chmod +x "$HOME/bin/"*
